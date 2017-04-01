@testset "Lines2D" begin

	@testset "Lines API" begin
		img = zeros(Gray{N0f8}, 10, 10)
		expected = copy(img)
		expected[diagind(expected)] = one(Gray{N0f8})
		res = line(img, 1, 1, 10, 10)
		@test expected == res
		res = line(img, 1, 1, 10, 10, bresenham)
		@test expected == res
		res = line(img, 1, 1, 10, 10, one(Gray{N0f8}), bresenham)
		@test expected == res
		res = line(img, 1, 1, 10, 10, one(Gray{N0f8}))
		@test expected == res
		res = line(img, CartesianIndex(1, 1), CartesianIndex(10, 10))
		@test expected == res
		res = line(img, CartesianIndex(1, 1), CartesianIndex(10, 10), bresenham)
		@test expected == res
		res = line(img, CartesianIndex(1, 1), CartesianIndex(10, 10), one(Gray{N0f8}), bresenham)
		@test expected == res
		res = line(img, CartesianIndex(1, 1), CartesianIndex(10, 10), one(Gray{N0f8}))
		@test expected == res
		expected[diagind(expected)] = Gray{N0f8}(0.5)
		res = line(img, 1, 1, 10, 10, Gray{N0f8}(0.5))
		@test expected == res
		img2 = zeros(RGB, 10, 10)
		expected = copy(img2)
		expected[diagind(expected)] = RGB{N0f8}(0.2, 0.3, 0.4)
		res = line(img2, 1, 1, 10, 10, RGB{N0f8}(0.2, 0.3, 0.4))
		@test expected == res
	end

	@testset "Bresenham" begin
		img = zeros(Gray{N0f8}, 10, 10)
		expected = copy(img)
		expected[diagind(expected)] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 1, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[diagind(expected)[1:5]] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 1, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[10, :] = one(Gray{N0f8})
		res = bresenham(copy(img), 10, 1, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[5, :] = one(Gray{N0f8})
		res = bresenham(copy(img), 5, 1, 5, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[5, 1:5] = one(Gray{N0f8})
		res = bresenham(copy(img), 5, 1, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[:, 10] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 10, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[:, 5] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 5, 10, 5, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[1:5, 5] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 5, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[10:9:91] = one(Gray{N0f8})
		res = bresenham(copy(img), 1, 10, 10, 1, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[10:9:55] = one(Gray{N0f8})
		res = bresenham(copy(img), 10, 1, 5, 6, one(Gray{N0f8}))
		@test expected == res

		img2 = zeros(RGB, 10, 10)
		expected = copy(img2)
		expected[diagind(expected)] = RGB{N0f8}(0.2, 0.3, 0.4)
		res = bresenham(copy(img2), 1, 1, 10, 10, RGB{N0f8}(0.2, 0.3, 0.4))
		@test expected == res
	end

	@testset "Xiaolin-Wu" begin
		img = zeros(Gray{N0f8}, 10, 10)
		expected = copy(img)
		expected[diagind(expected)] = one(Gray{N0f8})
		expected[1, 1] = Gray{N0f8}(0.5)
		expected[10, 10] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 1, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[diagind(expected)[1:5]] = one(Gray{N0f8})
		expected[1, 1] = Gray{N0f8}(0.5)
		expected[5, 5] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 1, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[10, :] = one(Gray{N0f8})
		expected[10, 1] = Gray{N0f8}(0.5)
		expected[10, 10] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 10, 1, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[5, :] = one(Gray{N0f8})
		expected[5, 1] = Gray{N0f8}(0.5)
		expected[5, 10] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 5, 1, 5, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[5, 1:5] = one(Gray{N0f8})
		expected[5, 1] = Gray{N0f8}(0.5)
		expected[5, 5] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 5, 1, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[:, 10] = one(Gray{N0f8})
		expected[1, 10] = Gray{N0f8}(0.5)
		expected[10, 10] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 10, 10, 10, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[:, 5] = one(Gray{N0f8})
		expected[1, 5] = Gray{N0f8}(0.5)
		expected[10, 5] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 5, 10, 5, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[1:5, 5] = one(Gray{N0f8})
		expected[1, 5] = Gray{N0f8}(0.5)
		expected[5, 5] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 5, 5, 5, one(Gray{N0f8}))
		@test expected == res

		expected = copy(img)
		expected[10:9:91] = one(Gray{N0f8})
		expected[10, 1] = Gray{N0f8}(0.5)
		expected[1, 10] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 1, 10, 10, 1, one(Gray{N0f8}))
		@test expected == res
		expected = copy(img)
		expected[10:9:55] = one(Gray{N0f8})
		expected[10, 1] = Gray{N0f8}(0.5)
		expected[5, 6] = Gray{N0f8}(0.5)
		res = xiaolin_wu(copy(img), 10, 1, 5, 6, one(Gray{N0f8}))
		@test expected == res
	end

	@testset "LineNormal" begin
		img = zeros(Gray, 10, 10)
		expected = copy(img)
		expected[1:10, 1] = 1
		line!(img, LineNormal(1, 0))
		@test img == expected
		fill!(img,zero(Gray))
		@test line(img, LineNormal(1, 0)) == expected
		expected[1:10, 1] = Gray(0.5)
		@test line(img, LineNormal(1, 0), Gray(0.5)) == expected
		fill!(expected,zero(Gray))
		expected[1:10,2] = expected[1:10,7] = expected[10,1:10] = Gray(0.3)
		line!(img, LineNormal(2, 0), Gray(0.3))
		line!(img, LineNormal(7, 0), Gray(0.3))
		line!(img, LineNormal(10, π/2), Gray(0.3))
		@test img == expected
		fill!(img,zero(Gray))
		fill!(expected,zero(Gray))
		for i in 1:10
			expected[i,10-i+1] = 1
		end
		@test line(img, LineNormal(7.5, π/4)) == expected
		for i in 1:10
			expected[i,10-i+1] = 0.8
		end
		fill!(expected, Gray(0))
		for i in 1:10
			expected[i,i] = Gray(0.8)
		end
		@test line(img, LineNormal((0,-π/4)), Gray(0.8)) == expected
		img = zeros(Gray,3,3)
		expected = copy(img)
		@test line(img, LineNormal(4,0)) == expected
		@test line(img, LineNormal(4,π/2)) == expected
		@test line(img, LineNormal(5,π/4)) == expected
	end
end