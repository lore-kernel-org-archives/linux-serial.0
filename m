Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493268;
	b=mAR7qPfjA3yryfemkEahV7dJIT/C6QuJRQM+RQfCbjqskkS1apVBTUF+V1+onx25N7Ph
	 7IGDWo5wXbqudR1sniMbcFGaedQFQJWlht6USpA/o+hwsegp/V+gUkQuKflZMDMO7pktQ
	 A36XwDpOdWy9QZxmyaNoM+Qja3Y1/QUaj/U899YXw5apWWiXkVEFl7P9N7Bi/J7XFoFbd
	 KfuZH5GUPRbXrVx1KElCnvEp5lgumhsuucuZ8opeLbLnxtEYK9/Fn1BwZOKTSPpWvFtZv
	 DYBxCfFFr6DwfT+aKxKOi4uYpbxErcxBejf1yuWY1o7olUfO6oJ3Tq74OZj2byw/MBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0yRGXMpxwUTECTA0OiqRhmW1BI9DpdkM0ZTAbE3p3cU=;
	b=cYM+5+/3ngxtsu+2qEikFNsuktt2i6d4DAAWNTx5oXaRCQ56Hqi4WJeHxa5C+Tf2noqz
	 tLPr68m5DP1rqEPFFhEdtNBm35tPty7ZHjZAKPPJDFDTWAZe0vnS09fwafKOUrhNiSTys
	 iuot6BE/9DUVhAg5glPWRnyZtFJZcSmocoGke5p8jXEKBCayHNzESUnQT4wSkttmerShN
	 vYLukiRc/gNQbwhufg9xGnbQm0dIh+sOWW52PVyaaP8oCN+mzMMz/RisU9yigU2K1GMoC
	 KttVutG+FbQixpRw2DgII7XXOJ6kZI2IqBuI/EwWqmdS1AYX2K2nMsIIccZB7FxmwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JYrXLtbI;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C460A2600
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 10:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82C460A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JYrXLtbI
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so244547c88.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493267; x=1793098067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0yRGXMpxwUTECTA0OiqRhmW1BI9DpdkM0ZTAbE3p3cU=;
        b=JYrXLtbIFCXTKM/cTXXtiv/Y8JVYTDcHoZER3E4Nb7kDkRKdFX6BeaNmLOtAhp8Ya6
         dLmJUQ9N+TLQu6IAzgM9uo1kat4SU24m/CP5JMk63ifOZMiUtd5u+l/4SmCZsFdnQB/C
         Ux/GMryUZGOW9Of4dphU5cwdq0J1jimF9NTg7mCFjzaOSdtGqEAHH6m8Lf2m1HVJmcrV
         X7eNZuW0cug5+Iah0mXS8gr6ICaNNHZPZSvQTdvscfco16SCSudHS8fQe875Q3JqMxwB
         HDylZVhAkUijOhUcihLhgbY2K7mOYthCTCihzwmZDhof4IfDCiYFlQYvYrOeBglHfBDE
         Dkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493267; x=1793098067;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0yRGXMpxwUTECTA0OiqRhmW1BI9DpdkM0ZTAbE3p3cU=;
        b=LgVOeiejhol3gx893YQGHrK3YQwuWGuR9UTM3JByF26elBp6KjrINxPP4q0bjPgdu7
         P7IlSwwWlILq7b4GbXtTTgKBaaF+cVRkK73g5gnuLtkXQT/xDGL/18/ODJIKA2KBzUnF
         V1mCNgoYmw09VaYfN7sAc+5odrr0CNOetfWy8kMKfisSUdvVy8h40jtTtw75X6f+A5Qy
         hpwbTWa4qaYkvoby3CzpawBx4UL9iqYtnvYOzp5NG2NIzIm8l1fQTJk6aZl7gVO9UN0+
         CMiXMQMMT6RLRd5PAlc366YWeL1bkE8TpKGpY7nyOHcofy4/2skiKNw4Fda/WMH3SFfS
         yTYw==
X-Gm-Message-State: AFq9FYJRmDfQCIVd80DD/u8FgYQ0acAgv75vXHCyeevJxnnNO+6xh1Es
	V2s3dDq6ZukvAAszuf2ZD5bP2jAETZtzCxlL/jW1FvKQsP2dHZgi5J70
X-Gm-Gg: AYBFou1RDHnoEZ4I1hwIgE28e7OTn9Dp9RTkSOPeOw2lfs/N807TmlSHMkiLadr8k25
	UUnpFmJDtfKxdi8x5Jc61wagZwTeNr3vW7eTmMZdOHsHAaka2zyP69D809OAQCLqOTW84tXuxwP
	Mbo/G4WWzzLoSgMHoCZKZ+Zpq4+EePU6GPT6pkEmSp3dlwKc1IWRWA3xNOzottVdBZ/YJqvAXnX
	TVn3ib/S1G3jCALQznkFhW9dszhApM25XfMG0YlWwW86Sbmh7Q++SO0IpfxSpJh467PGU1zKbT5
	ELPZ7rwoPS42YhWPu1U6BGPWDtCYKdAXFya2Hbh+cTVErDbYOOnWBXwNR47evL62EHHLf7MX5i3
	FSYFSJJuKFsfj0NV1rH+s0B313aIRFlNwrMtdh7833IApEeLAlPHMoC+M4FaWiy9k/Sm+9GRnan
	eqluvMe0+KUQMHbHYPv+R8ZA9wR3uePqz0aQi+ZW9E8D7geWPpwdoVJ97vlhYVJA1i5TP5Yv8yr
	CDy5+EADq/0OInPnXBWC9fdiOmJFrKtvj2PZIRPXCJpxT1RFt6KSpyIlFGE9rWMOQ/JM/2jmR4P
	kJn30bs=
X-Received: by 2002:a05:701b:4511:20b0:151:2068:e81f with SMTP id a92af1059eb24-1851310a457mr14502929c88.27.1792493266915;
        Tue, 20 Oct 2026 03:47:46 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm34662429c88.5.2026.10.20.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:47:46 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF readback
Date: Tue, 20 Oct 2026 07:47:30 -0300
Message-ID: <20261020104730.28646-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri,

On Tue, 20 Oct 2026, Jiri Slaby wrote:

> Do I understand correctly, that this equivalent to:
>   if (is_power_of_2(reg + 1))
> ?

Yes, given the existing reg != 0 check. I kept the explicit form in v2
to keep the change minimal, but I'll use

  reg && is_power_of_2(reg + 1)

in v3, it reads better.

The two forms only differ for U32_MAX, where reg + 1 wraps to 0. But that
isn't a valid DLF readback here.

Thanks,
Vinicius
