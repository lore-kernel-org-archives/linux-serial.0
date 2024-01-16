Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAF1D6A9
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441455; cv=none; b=WUokhjJ3rtkZIn5ycJ0Ysr8UEmc7MOcyEkfzZ3lPujD2mAN1DiPnfhsn8e8TOCcmaFexu/F1w4PBcncbNo00atzDuPxdSQamaQBEDHhrPvoJVZF8w7T2OOxrfnOHdGrd64OoHPADj2bUInCt8rHmT68/BUhC79cAAW0vHCU/60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441455; c=relaxed/simple;
	bh=xU4KQeSltnnDRQD+yHUOZe3gtICh4P80ycwHtkx2UZc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GSan/Cv6vxLBm/wp/QqxjUnu715oyy61b6ZofuWOESPmGcG7tULLg60USd0x8OGLP2lfF30nkMCx/+lNYT1zEn3F+ayfxOTyGkU+V2dXnJRrWir19YwqhUzTW3sfAkicYjZ0W/28fR5HiEZplnqaIfKVj31dU1qnMPdnUiTuO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4jKb0PF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4jKb0PF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55976b32185so1511961a12.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705441447; x=1706046247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLO36tzxnimBzPqtIVgeQR8/eAGxteoTajovxvCKsCg=;
        b=A4jKb0PF5eSgGxUbrU65n1eE26UhFtV5Cgpbkmv0xP0i3BnHXn/JWVmCZCCb7RK34D
         lrZIJAXFobuKf98T8FovWex16fViwSP/ZMDNqhzdHkqDk/Ap0brWI5AwhJ5BpOwcFrpY
         DnLJM+7k/dC4rodi45CGYhNleWlwtJ209YflS3U+6DbOfSztg+OUhb0QZEHpzxxyiTMJ
         dmfHmHVCWhIy4gpuF/6nsC5FGTRe1ErE/dIF8wL/ek/Wqwxe3e3dFHoQMhx1ZUwEO67q
         YRFuXQcJfyrIuHy16tzOyX3lk/pMml1Yiq94gDovLuWC9sNQmx2n7tiZaU/CuYR1m2Or
         tpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441447; x=1706046247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLO36tzxnimBzPqtIVgeQR8/eAGxteoTajovxvCKsCg=;
        b=DbyXzYcEMhElZCEw4KC09+TNy6tspfaQb8xV1DaZzraYyNLNMtxRMVD90+VvoiHoR4
         Z5AfCG6d9UZvUTpN4JiWKhTLsjdVyd/76RMOABNNbXuQ06kwuO7Lh5fyLKxMWEEXZJ/x
         M6k2pI4M7IjrFVzx6LEcuAjqgG/1Hl+XyOaWtek3giblVJYHZ0FgmY7i8lYPjQLQkVzU
         3rCVR7RJufn3MFm1rWFqYpgfhmhmr/lHwWp0yyA/WAwbW9gv6EgJGwFZaRVJiAboTXcl
         /afTV7T4Bv2/v8zPtv1o7FFQxPZPFMCYhFz477GV1lS+LKqdv3RjvI6jO3egtTZND+U+
         x4ag==
X-Gm-Message-State: AOJu0YwPYwWJ9UAk4Q4jzqDuno//g1IFuq5jzdDi5I9WUx9TZdiJwm/u
	DqTR9tJMpvBYcyVLLi6jRfo=
X-Google-Smtp-Source: AGHT+IEybgTJbTXrkOLJ23kQjpDiQLJCIX00oKJSsMuxAhI6f505S0daM1n4tJaNcUhVhJ9Zu4e6KA==
X-Received: by 2002:a05:6402:430d:b0:559:c96a:f745 with SMTP id m13-20020a056402430d00b00559c96af745mr367349edc.54.1705441446753;
        Tue, 16 Jan 2024 13:44:06 -0800 (PST)
Received: from michael-VirtualBox (89-139-16-170.bb.netvision.net.il. [89.139.16.170])
        by smtp.gmail.com with ESMTPSA id k8-20020a056402048800b00558a6025397sm6988490edv.14.2024.01.16.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:44:06 -0800 (PST)
Date: Tue, 16 Jan 2024 23:44:04 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	daniel.beer@igorinstitute.com, David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <Zab4pAQ7SGso8SYh@michael-VirtualBox>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <e1698466-a4e8-4120-ae51-d77c3d299fc5@christina-quast.de>
 <ZZSDTes35xnlFlX3@michael-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZSDTes35xnlFlX3@michael-VirtualBox>

On Tue, Jan 02, 2024 at 11:42:37PM +0200, Michael Zaidman wrote:
> On Thu, Dec 28, 2023 at 12:50:08PM +0100, Christina Quast wrote:
> > Hi everyone!
> > 
> > On 12/18/23 10:31, Christina Quast wrote:
> > > Adds the serial driver for FT260 USB HID devices, providing direct and
> > > simplified access to UART functionality without the need for FT260 HID
> > > report format knowledge.
> > > 
> > > This chip implements an UART and I2C interface, but only the latter was
> > > previously supported with a kernel driver. For the UART interface, only
> > > FTDI example code using hidraw from userspace was available.
> > > 
> > > This commit adds a serial interface /dev/ttyFTx (FT as in FT260), which
> > > implements tty serial driver ops, facilitating baudrate configuration,
> > > data transmission and reception, termios settings.
> > > 
> > > Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> > > Signed-off-by: Christina Quast <contact@christina-quast.de>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: David Lamparter <equinox@diac24.net>
> > 
> > Is this already queued for 6.8?
> > 
> > Cheers and happy new year!
> > 
> > Christina
> > 
> 
> Thanks for this work!
> 
> I am adding Jiri Kosina, the maintainer of the HID subsystem.
> 
> The FTDI FT260 chip implements three functionalities: USB to I2C, UART,
> and GPIO bridges through two USB HID class interfaces.
> 
> I use the https://github.com/MichaelZaidman/hid-ft260 repository for FT260
> driver development. The I2C support has been upstreamed since 5.13. The code
> is mature enough and is I2C performance-tuned.
> 
> The initial GPIO support was developed and committed into the mainline
> https://patchwork.kernel.org/project/linux-input/cover/20230211115752.26276-1-michael.zaidman@gmail.com/.
> 
> Two versions of the initial UART support were around for some time, and
> now they are unified in this commit.
> 
> I am going to test it with I2C traffic to exclude a suspect of possible
> impact on the I2C performance and will provide feedback in a week or two.
> 
> --Michael
> 

Hi Christina and Daniel,

I tested the patch and fixed several issues. I did it in the uart branch
of the https://github.com/MichaelZaidman/hid-ft260/tree/uart repository.

4a8430c hid-ft260: uart: protect write_buf concurrent access
bec5f5b hid-ft260: uart: remove dead code
9a8e145 hid-ft260: fix i2c regression
fa8b63f hid-ft260: fix Wformat warning
1b1a2c6 hid-ft260: fix incompatible-pointer-types error
60bf153 hid-ft260: Add serial driver
16b6536 hid-ft260: driver code from mainline

Then, I briefly measured the performance impact on I2C traffic by simultaneously
writing into UART at 921600 baud rate and into EEPROM via I2C at 100KHz. The I2C
speed was limited by EEPROM, slightly degrading compared to the I2C-only case.
 
Also, please see my comments inline in the original e-mail with the patch.

--Michael

