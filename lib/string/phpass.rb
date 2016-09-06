require 'digest/md5'

class String
	def phpass(encpass)
		return "*" if !encpass || encpass.size < 12
		table = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
		cnt = table.index(encpass[3..3])
		return "*" if cnt > 31
		pass = self
		cnt = 1 << cnt
		salt = encpass[4, 8]
		hash = Digest::MD5.digest(salt + pass)
		cnt.times{
			hash = Digest::MD5.digest(hash + pass)
		}

		result = encpass[0, 12]
		i = 0
		cnt = 16
		while i < cnt
			val = hash[i].ord; i += 1
			result += table[val & 0x3f, 1]

			val |= hash[i].ord << 8 if i < cnt
			result += table[(val >> 6) & 0x3f, 1]
			i += 1
			break if i >= cnt

			val |= hash[i].ord << 16 if i < cnt
			result += table[(val >> 12) & 0x3f, 1]
			i += 1
			break if i >= cnt

			result += table[(val >> 18) & 0x3f, 1]
		end
		return result
	end

	def gen_phpass
		# todo: better random generation?
		self.phpass('$P$B' + ([*'0'..'9'] + [*'a'..'z'] + [*'A'..'Z']).sample(8).join)
	end
end
