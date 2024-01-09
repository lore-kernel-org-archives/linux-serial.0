Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E88539F;
	Tue,  9 Jan 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX+OQrBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E27C433C7;
	Tue,  9 Jan 2024 04:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704773304;
	bh=vxop1P25YkHwxNMZhEWdRl+DWP4xO/rIKADXrQ5Hngo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WX+OQrBQS/WTPVQ3qaPUBruOwgpd5pTj3QZw4+gnvxMJk/4UsT8fs/A4wmq36KwhF
	 Odo7nBB7DDouyGwDMXNzgB8HFk/f6dC4od4zdqQLnjjVy4HzCOz4C2Led8B0/2zp4v
	 8sB3Twr4VGKfnVPTce5JRDSyH2rJjwYPm5Zt3+AA5OZWR4xJfcLa9CDnX57EaP8CUv
	 kNoxgteqMU3krWxw2vTRCAZaES5adyTLGAWFym5YU6dXC5WnAvRMUrTI4d7tVr+DE8
	 0VzUPLINE6wSA5Y8suH/TbIRah9IpGJTOH5ekd5Fz8CXRHX4BpmDbtFwhfgtoy8ui8
	 62pRsMrhFNufg==
Received: (nullmailer pid 2627564 invoked by uid 1000);
	Tue, 09 Jan 2024 04:08:22 -0000
Date: Mon, 8 Jan 2024 21:08:22 -0700
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 01/12] dt-bindings: clock: google,gs101-clock: add
 PERIC0 clock management unit
Message-ID: <20240109040822.GB2619804-robh@kernel.org>
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
 <20231228125805.661725-2-tudor.ambarus@linaro.org>
 <CADrjBPo8tARhHjpBJMABV3dqrd6AqhPVASTK5+3rSmoDA8eStw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPo8tARhHjpBJMABV3dqrd6AqhPVASTK5+3rSmoDA8eStw@mail.gmail.com>

On Mon, Jan 08, 2024 at 02:18:21PM +0000, Peter Griffin wrote:
> Hi Tudor,
> 
> On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >
> > Add dt-schema documentation for the Connectivity Peripheral 0 (PERIC0)
> > clock management unit.
> >
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > ---
> > v2:
> > - fix comments as per Sam's suggestion and collect his R-b tag
> > - Rob's suggestion of renaming the clock-names to just "bus" and "ip"
> >   was not implemented as I felt it affects readability in the driver
> >   and consistency with other exynos clock drivers. I will happily update
> >   the names in the -rc phase if someone else has a stronger opinion than
> >   mine.
> >
> 
> It would be good to get Krzysztof and Robs view on whether they agree
> with the above rationale or whether they would still like to see the
> names updated.
> 
> Personally I like the consistency, grepability and the fact the
> current name encodes whether it is a gate, divider into the name.
> Seeing 'sss' or 'ip' as a clock name in the driver code doesn't tell
> you a lot without having to then cross reference with the dts.
> 
> Is there some rationale and/or benefit behind having the shorter
> names? The only thing I could think of is trying to partially re-use
> this file on future SoCs like gs201 which might be clocked
> differently, but then these exynos clock drivers seem to be SoC
> specific anyway.

The point of -names is to identify one entry from another in the list. 
Having the name of the block is just redundant.

I like consistency, but not when it's a pattern we don't want.

Rob

