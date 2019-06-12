function [vlrands50] = granulacao(vlrands50)
	for i=1:size(vlrands50, 2)
		if (vlrands50(i) < (fix(vlrands50(i))+0.3))
			vlrands50(i) = round(vlrands50(i));
		elseif (vlrands50(i) > (fix(vlrands50(i)) + 0.7))
			vlrands50(i) = round(vlrands50(i) + 1.0);
		else
			vlrands50(i) = round (vlrands50(i)) + 0.5;
	end;
end;