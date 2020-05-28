Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D568C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 22:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CAD208A7
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590705774;
	bh=ACS0Emrjl92rkSjIP6eCacc+3nIZpBSalJqBPmb4S+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTP83uig7/NpCEyQ1PavhrR/WdQwE492rSiYsH7BXp77euqk1YgieJCoZ2dljO6IH
	 Drr1+JNp3WvVV48YCS3s9cUtjgCHWqJizFgZ0N/I0eEcdXgZHxWTlFS9HUq/Gq9L2U
	 PetxNOIGy0HQ57T4HgnMqHNyFhG+MA25hIGUANT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437254AbgE1Wmx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 18:42:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44209 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437076AbgE1Wmv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 18:42:51 -0400
Received: by mail-io1-f65.google.com with SMTP id p20so251831iop.11;
        Thu, 28 May 2020 15:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2v4fXoeX6WkbPQBFbkJ9xyFPHQKXTzJ0kD/XhuAbXI=;
        b=D8ukURP4fx4p+8QVePT6Jrqjq4EpoQ8N4UhyQR5IQkG3YdLNttAY8DaZmCnd7wwyOP
         VK3mIea50bSPtqTUu1UhhiM2PTmcBsQEmAYOETwbA45MFGIS37nXumRxT552SZ5yPCF0
         jcE34b0CWrg6zG2a2PxLZdTwFPnlFTEOtBJmuy+8L+kb30ewwiUQZA4MDS1FuHrYR9hb
         LrFQKMiEVCAmuE7PxNhoMcJEYR0E/2FvIgm6IcpiPe0hnLU9JuDM9jQkr8uSxn/Y1vMT
         1m7/1w8B/ry32TkEaudnqED+lwXsnydH3iSOfY31Rk5pRfcoahyJ0xotExFQdS/Bixrp
         qXSQ==
X-Gm-Message-State: AOAM533ojwX4e5xNHmJoc6N/KOcGQfQvc4Xb6O+W/UwFeHSZYrvaJjfp
        BFFJJcyIuPK3HhO/60CHVm8/r2I=
X-Google-Smtp-Source: ABdhPJyvQGZ/X09rxzw+FFgW3czEMyF0VVuSqoiHjEToSQ3kfBEeiepD797L4Q4CNLyb/OQmsiB92g==
X-Received: by 2002:a5e:d619:: with SMTP id w25mr4203490iom.189.1590705770605;
        Thu, 28 May 2020 15:42:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f10sm3725798ilj.85.2020.05.28.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:42:50 -0700 (PDT)
Received: (nullmailer pid 815010 invoked by uid 1000);
        Thu, 28 May 2020 22:42:49 -0000
Date:   Thu, 28 May 2020 16:42:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com, jringle@gridpoint.com,
        m.brock@vanmierlo.com, pascal.huerst@gmail.com
Subject: Re: [PATCH v3 1/6] dt-bindings: sc16is7xx: Add flag to activate IrDA
 mode
Message-ID: <20200528224249.GA810596@bogus>
References: <20200521091152.404404-1-daniel@zonque.org>
 <20200521091152.404404-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091152.404404-2-daniel@zonque.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 21, 2020 at 11:11:47AM +0200, Daniel Mack wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> This series of uart controllers is able to work in IrDA mode.
> This adds a property to the device tree to enable that feature on
> selected ports if needed.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index c1091a923a89..4d1f55abe876 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -21,6 +21,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 = active high,
>      1 = active low.
> +- linux,irda-mode-ports: An array that lists the indices of the port that
> +			 should operate in IrDA mode.

Sorry, should have mentioned to drop 'linux,' too. With that,

Reviewed-by: Rob Herring <robh@kernel.org>
