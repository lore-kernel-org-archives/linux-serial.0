Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268D58FD2A
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655266; cv=none; b=Uwz/RJZBz3XtkVZTMCTd7sUn2ZZ1YnFXsKH7fNo7X9+zZfIwG11aRVj6Nu7caGRkqLIp02/YWFrnIzkYBZAVCgf2wtplYC8WlEXPzeYu/5fqICJqg5zYTpKVcMcY5jExUKtJfui5SAxN9l70SofdgWlrAd6h6MUJEY15r4Oi+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655266; c=relaxed/simple;
	bh=tR4az/LXX1uPEVPqZly1MWtWJFRe2M+C1Rbz7GqFq7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVZ3r6iEHW3ey444AadHOTjvRZTO8EacdZZdSS2QKo9+PsB1RRuwjyrnTcMbX8oTx+xdbhNY9/FCL5LwUlgQT2rnfN9dCKXi2ZRtPOHggB0GIzTQOTPNDYgBQ1tqdA2Czzft05OVaQoZbBuBU0B23qopIOTi5P65iuxoy48HXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78565a41a19so283871137.1
        for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 07:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655264; x=1790260064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2PUKRWOpjzB1uTEg8aunaQFp5fJugA1o1ujUfXk8Z4Y=;
        b=jIYovZ+NL4UJP78rTMcATOHMcC0MPsVu/7ZAc+5djoXcr6KAjZgL4vCljgTCvnTAP1
         kfATSIzJ3ZhEz4X0b4IW5lAtl6mk+Y6KY1I60WLJkmJjJoiMJ+EUjM5wrZogyB/Kg/+3
         XJPqGKNPOsdFbKNu4w25Ua5p0/wtSgHiqEwx/HzT/dGwulbZibdUv2gzjG1QTbt3BZB3
         T6vyCSx0CaLovuqgzvmJcW6mOsg4+aZmWUGsIPRELhdaRIA35gOPQNfWKwHp4PvobWko
         EKrvs6Gqi+tK/+fCBcNixwnF6rb7D4n+iSObs4CI9nXGZ2XFO70oVwmN5EcU0NueA2KH
         lG4w==
X-Forwarded-Encrypted: i=1; AKwUvBzyKzmiwVOldoPTDkgLORpHLWReVg97l0AyyUzTTRb4ZhVoe1Er/BX9nbm2Tnx70fcj63L0va+F/bt4Fw4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsSylZ4vwWmPNgBs9abW7QW0OyD8xPTRerSaCq3NK0EO855md/
	cGJ5m6VIe564CZNPc9OFr+l17Cz3105Z7ksTKfHamZcNNLYZaWAYh/eQYxjN4+0t
X-Gm-Gg: AYBFou21ICAfDoPrGA4VbcZfN+INt01EDWB7eC5E8dwrtSSChT01MeHRYYiBe7/eFfR
	iwKYaesvFBOKLsDR09bZc50xg8Hr5DlRX8yYaGwDHoY+tez8phwm75SzbF7xm380xco94ddFyNX
	J3p4Fqyyh8ZIrIGljYj/EB+h3OOklggZ16w7hpXBh84enup+Mu9shvAbONBw68xSue0NbBJhGPv
	jLzMcOHj4tXRKhq3+iG9J7+VX/iSQFTCXB/O2jTEsgNcAo6UUmOILcJfnKTMD3PKVDaD4nI/Pa7
	rGyjwNB99fY9mSag40ck61reCg5N6mj7bZ8LDwvMf8A9uv4SOCrWfdgEgHcSmRAZeDH+X8vmCPN
	uoLw3AkW2H9adLW73G0OHULpZSOix1bu+fslqX/DUh8dRIs9yghqUFmBB4U8fbVSHsEYoxythk9
	AHZnGIjxvghHwTUIz7bvqEh0jWrjHY3WGKLrA/0CcX9COBNRCyChWxMS35VWz2tCb7uXqTKfYK1
	cZx1hSMj5GUDDTGFw7aZBIfLoT6LJtyid37ig==
X-Received: by 2002:a05:6102:4424:b0:7a2:6b90:3dbb with SMTP id ada2fe7eead31-7a26b9057a0mr764329137.25.1789655263507;
        Thu, 17 Sep 2026 07:27:43 -0700 (PDT)
Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com. [74.125.227.40])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1e3a5938bsm3488998137.12.2026.09.17.07.27.42
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 07:27:43 -0700 (PDT)
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a03fe69236so332331137.2
        for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 07:27:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3ATiWkO7MpFdotBXXBCDR98Bd+PXreP5aMOT55h2ip1Hai/Z+TKZr6WB41MrlkLbPKHyBWgSElFVZ/FA=@vger.kernel.org
X-Received: by 2002:a05:6102:3f06:b0:79d:e3a3:4ec7 with SMTP id
 ada2fe7eead31-7a028d64e77mr6733201137.8.1789655262508; Thu, 17 Sep 2026
 07:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>
 <20260917141443.B68B91F000FF@smtp.kernel.org>
In-Reply-To: <20260917141443.B68B91F000FF@smtp.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2026 16:27:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgJkwkoF0-ptQ9g_8E5j1Oa8G41nBiiOfY+KF_p7XAxQ@mail.gmail.com>
X-Gm-Features: AcwNN1Ush8QJQXkRhAfTq-tWcBhQ0EMlNvr04HXsZawb41gsyRT18-MJVn4i_LQ
Message-ID: <CAMuHMdVgJkwkoF0-ptQ9g_8E5j1Oa8G41nBiiOfY+KF_p7XAxQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Increase number of DMA
 channels to 6
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

Hi Sashiko,

On Thu, 17 Sept 2026 at 16:14, <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt-bindings: schema allows 6 DMAs for older SCIF hardware
> --
>
> commit ca96f7e40234020713acb3baf706d0b07d5dcc48
> Author: Geert Uytterhoeven <geert@linux-m68k.org>
>
> dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6
>
> This commit updates the renesas,scif device tree binding to allow up to 6
> DMA channels. This supports the R-Car X5H hardware where SCIF serial
> interfaces are connected to three DMACs.

I wouldn't bother adding further restrictions, as these are not related
to the actual I2C block, but to on-SoC wiring.  DMARQ is just a single
signal going from the serial block to one or more DMAC instances.
The number may also differs among serial instances on an SoC.

See also my similar reply for rcar-i2c:
https://lore.kernel.org/all/CAMuHMdXj04QoxituCF3wRcyzN7qZrVBn7-ukNkKDd0OfhB8zOQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
