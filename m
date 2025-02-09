Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A41DFE1;
	Sun,  9 Feb 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106803; cv=none; b=hm8035iGncnvuiBjKoRNtsdW2E06AWXNiwdOIuJ+qQ0s2LGya4U9/5ZmmSIVKd73P0FNzapKDh5SjIL+CvfQ3MuyQmXTfrVuTXYt5DuvDvl0ufkWg4MTx7ryX1N84sbeXAV+OqVgyG8o7VPl0iWWDrXJ4GtyRZgnWFH6zzfuKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106803; c=relaxed/simple;
	bh=KY+2MWjuH2v4j9LnacdOFMSvtYVkE7RsvZRwGr/i98g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go/ArCr+e5wDz/+9sqdJ4p+P7JQ4ZCcydNDL/G4h+Zt2NE6oLd8l7mvoxrMI2kncQpWwGVc9/fiSKemM/mXrBOoHtWh1xGS96973sTC9lRdKfOBbDrpHf/EdtIAOkXX4WNqCWQnLZpBjOohZO0n5horWollFsRMqUcIv+whuPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOlLo7jX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOlLo7jX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494DFC4CEDD;
	Sun,  9 Feb 2025 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739106803;
	bh=KY+2MWjuH2v4j9LnacdOFMSvtYVkE7RsvZRwGr/i98g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOlLo7jXi17egTi/YFh3PzU/Y0IT7NuVIK46wyh5TtJcTaAdJt++PENlhszLbFWqA
	 5+muXfxpjfoZ1vrxH3al/9MMzmR65pGefhWVLYSpuGqEqG24g9aH8kVy9XqabJkmmo
	 ik0oj+RDrYCGqc4DxBT/lHG9PwlcIVOrlbFnw/m2dPwpMBav6YGzjHGgN34idR3k6d
	 0j2Vrw9DiPzI/AHrH1KSyuAwzXKgKiYC0/eNp33R2imoMHJx3wXKG+Pwe2XhrqAwq6
	 R8cNBcqnnMZ0oByklOFdNN/dkgPOmJ/i9hv6VGDxqarQuEaeGalDh4+DtFztYra/Te
	 IqKBvQxSdnyug==
Date: Sun, 9 Feb 2025 14:13:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sergey Lisov <sleirsgoevy@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: samsung: add exynos7870-uart
 compatible
Message-ID: <20250209-roaring-wasp-of-variation-58dc8e@krzk-bin>
References: <20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org>
 <20250204-exynos7870-uart-v1-1-06be6aa96284@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204-exynos7870-uart-v1-1-06be6aa96284@disroot.org>

On Tue, Feb 04, 2025 at 02:08:45AM +0530, Kaustabh Chakraborty wrote:
> Document the compatible string for Exynos7870's UART driver. The devicetree
> property samsung,uart-fifosize must be mandatory, as the driver enquires about
> the FIFO sizes.

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Best regards,
Krzysztof

