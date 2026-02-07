Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3703385A5;
	Sat,  7 Feb 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770461948; cv=none; b=p/qUHT4uQ30ZD2hxfUJlprunB2dPz6z2LuNGSBvQ/H/y3c/z0skAhrDCHtSPUEErn4BxjqIloxBer7vMj1YweE4hNkUOchhQ/6ALhZ+9SSUXFLILVCU6/Eh1AY7wC2vZLdmg4bfrPJ3AwT/KMbpQu/WPr+HJGX6S0VhiwHjB4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770461948; c=relaxed/simple;
	bh=LeBjoFE01jmavA3LFYkp2oQ2vFfSUBNi+LrOIhvp+ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKL050+8mVAvvSVoqvfS5wI2H1iZeSRkwk1cyYHjKaXCJR8Zp1fWOGSJfXd1Htd81KXLfiN101mrM+8Nx895h5FXqzzc87/WjnSmeJ5KGB1OBrgo6EnLlynR+XF5Kd26/44AMY4PnHABOTcwOfZg5utoBXQiKHE6/rzlUj2TWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf5PEQ3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf5PEQ3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6999C116D0;
	Sat,  7 Feb 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770461948;
	bh=LeBjoFE01jmavA3LFYkp2oQ2vFfSUBNi+LrOIhvp+ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jf5PEQ3t+kYsnrAn2zyWd2G0akmQiXmVc+mujySm79xEIhRvY40/aDOMW+lA0gFym
	 Xt6GR1cxiICZ6YxYvLgI8xjK42eQtqU/gylzImiJlGH/zEkVRrlaOfQ0r3jd8SlvA8
	 37XlDqRdElNWL8SEMX5EVlWkqWRGNcgajoxvzD9riUHW9j4V3B7FdLhm6plHgW1Cid
	 RrZfoYkTapRnRLdT1WDp0Tz71V5kRG9EXAYZedP0+7Vl7gNMQAPioOQWAYeKh7g/m4
	 JtjbHdx+lFTiTsFkzEsHaYHa3kh0qFyR/XYlzP0m1zRobGW+qSVWA0l7XzfQWOCswt
	 G6HUx7XivFw4A==
Date: Sat, 7 Feb 2026 11:59:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Fabio Estevam <festevam@nabladev.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: serial: snps-dw-apb-uart: Add support
 for RV1103B
Message-ID: <20260207-unselfish-gorgeous-duck-cfc1ce@quoll>
References: <20260206181309.2696095-1-festevam@gmail.com>
 <20260206181309.2696095-8-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206181309.2696095-8-festevam@gmail.com>

On Fri, Feb 06, 2026 at 03:13:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The UART used in the RV1103B SoC is still the same dw-apb-uart compatible
> type as on the SoCs that came before, so add the RV1103B to the list
> of variants.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Greg expressed MANY times that patches for him should be sent
separately.

Best regards,
Krzysztof

