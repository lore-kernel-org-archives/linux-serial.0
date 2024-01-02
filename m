Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEB168AD
	for <linux-serial@vger.kernel.org>; Tue,  2 Jan 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzAPlw9B"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3373bc6d625so1999422f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 02 Jan 2024 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704231761; x=1704836561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19PwTm21Bm6mHRAhslwfN8LpsQRjI+/W5UlRgbA4Bbg=;
        b=JzAPlw9BkXdVbnCTYTsNFhJEfSEjUL7bdZLJnOxgtc8/lV7M1VlGKaCMvAKG4lGr5c
         hx+eA5/1z9PCqRH7/zFa50a1Ih36g4Mj1kCtL39O4W6Cb+fDzow2K9CiGvSDk7kAmNmY
         qM/+uovEH28uDs/mOvLQ05GEEAtwk8M+xvpP3pHsKdQo7YJW5qXLgm4CddJ7gJJ7MlPl
         x6E3NLbefsgXGx/KweQZVOrB6T5Mtl7WowFhJ/bFCU0lc+TCxceUmwo9JGAol1oQIcn8
         dMTTTdNSDkRgpy8ZC+JFxrHqh/zUHryGoLyVYTp8wYdGH/6InPJ5jIWJFVTZYpsLHxKz
         mgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704231761; x=1704836561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19PwTm21Bm6mHRAhslwfN8LpsQRjI+/W5UlRgbA4Bbg=;
        b=b3YAWCSF/OYTLJGsyKDZUArA3ACMED/WSaerRLchmfYUSulWJBpBD/35swU8D3D8ZZ
         3kn8ApT0jMYzkOlOvBBgbVnf7RS1o8hxaMX21YdL7ggejjAQjC3alFg0ZTa2IyYJyQtL
         /95T1Dvdu4nPmniz0CGjwgUp1UwWBbOrw1DImHwJPQNxHZAZ1NsZTPY2tUYboNH89b7k
         AK8KSPzZSy0ylRIkP3P7Elp8QcoblMhrbDsrdu7i965Tkvhm1vHsbzPLiroTMLqxnIUg
         ZnBM0eFCalCvWBn2NZySZWhnMvbkOh11wzoaQ8HMxT4EWAZOGiYtLjqDV+haS0GfyDqO
         qywg==
X-Gm-Message-State: AOJu0YwvN91DYhTDVw6yphiAxotx40t5n5V4EoHG2fyXL9sgFDBoWjgk
	HiMIAfRjY2Y6gGiU6o+GEK4=
X-Google-Smtp-Source: AGHT+IH90GJ9ugwxKNnQ/8+OqNgIRYNteZVqtL8DbZGOQvxeBFcjrGQA+OD4lzl62oAeryxHmojd7g==
X-Received: by 2002:adf:fc47:0:b0:336:807b:ed62 with SMTP id e7-20020adffc47000000b00336807bed62mr10732553wrs.60.1704231760355;
        Tue, 02 Jan 2024 13:42:40 -0800 (PST)
Received: from michael-VirtualBox (89-138-180-64.bb.netvision.net.il. [89.138.180.64])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b003366aad3564sm29485377wro.30.2024.01.02.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:42:39 -0800 (PST)
Date: Tue, 2 Jan 2024 23:42:37 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	daniel.beer@igorinstitute.com, David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>, michael.zaidman@gmail.com
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZZSDTes35xnlFlX3@michael-VirtualBox>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <e1698466-a4e8-4120-ae51-d77c3d299fc5@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1698466-a4e8-4120-ae51-d77c3d299fc5@christina-quast.de>

On Thu, Dec 28, 2023 at 12:50:08PM +0100, Christina Quast wrote:
> Hi everyone!
> 
> On 12/18/23 10:31, Christina Quast wrote:
> > Adds the serial driver for FT260 USB HID devices, providing direct and
> > simplified access to UART functionality without the need for FT260 HID
> > report format knowledge.
> > 
> > This chip implements an UART and I2C interface, but only the latter was
> > previously supported with a kernel driver. For the UART interface, only
> > FTDI example code using hidraw from userspace was available.
> > 
> > This commit adds a serial interface /dev/ttyFTx (FT as in FT260), which
> > implements tty serial driver ops, facilitating baudrate configuration,
> > data transmission and reception, termios settings.
> > 
> > Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> > Signed-off-by: Christina Quast <contact@christina-quast.de>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: David Lamparter <equinox@diac24.net>
> 
> Is this already queued for 6.8?
> 
> Cheers and happy new year!
> 
> Christina
> 

Thanks for this work!

I am adding Jiri Kosina, the maintainer of the HID subsystem.

The FTDI FT260 chip implements three functionalities: USB to I2C, UART,
and GPIO bridges through two USB HID class interfaces.

I use the https://github.com/MichaelZaidman/hid-ft260 repository for FT260
driver development. The I2C support has been upstreamed since 5.13. The code
is mature enough and is I2C performance-tuned.

The initial GPIO support was developed and committed into the mainline
https://patchwork.kernel.org/project/linux-input/cover/20230211115752.26276-1-michael.zaidman@gmail.com/.

Two versions of the initial UART support were around for some time, and
now they are unified in this commit.

I am going to test it with I2C traffic to exclude a suspect of possible
impact on the I2C performance and will provide feedback in a week or two.

--Michael

> > ---
> > 
> > V1 -> V2: Adressed review comments, added power saving mode quirk
> > V2 -> V3: Added return 0 in ft260_i2c_probe function
> > V3 -> V4:
> >   - Adressed review comments
> >   - Added get_icount
> >   - Fixed tty port lifetime bug
> > 
> >   drivers/hid/hid-ft260.c | 833 +++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 781 insertions(+), 52 deletions(-)
