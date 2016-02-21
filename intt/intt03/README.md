intt03
======

距離の正規化

### 評価

### TODO



### work

```
# bash
system_profiler SPDisplaysDataType | grep Resolution | awk '{printf "%s\,%s\n",$2,$4}'
# ruby
a = `system_profiler SPDisplaysDataType | grep Resolution`.split().values_at(1,3)
```



@disp = `system_profiler SPDisplaysDataType | grep Resolution`.split().values_at(1,3)

x = @disp[0].to_i
y = @disp[1].to_i

def normalize(p, screen)
	return [p[0]/(screensize[0].to_i), p[1]/(@disp[1].to_i]
end 
