Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DCC54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622F72084D
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBq0MwYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD0QuR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgD0QuR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 12:50:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA607C03C1A8
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:50:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so387921wmj.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iaoxedZxnXT61na9+8gBwfFrGXWaoAZVnNqVew8CicM=;
        b=DBq0MwYm3T2upLNWVYRbzSBKmNIaSmK7ljQkEE1/W/CM09rU0ZjpzInA+LsmKDA2Oy
         xEMR/LAtw14xIHXftGb3u/7siF/KTUUL2mBtbQ9AwJwMdJmcQ0U2v58CNawZXYgaGW1R
         tyHVahfQ6VozcsVMImFLPLoEUgAknBq1fdn5BVCEKsxt3XD10fZEwTnj9YU5yVu5CdS2
         BTRwpEBnz/Ni++2BKyY05SdGTfbWPqsOsXuyzp+oVytDkPY7b8aT8r1FZR63Lj8oQ7uz
         sbDyOED/LFJx1eBGJt8zlAV+nRr7g011JzhujAn/JnFv9+yH5KO37wNfabh+5LXx8naa
         Lp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iaoxedZxnXT61na9+8gBwfFrGXWaoAZVnNqVew8CicM=;
        b=tp0B0Zkg0kr944UQBFeqNq+4jPR09l8Nj4EmCQHqeBRFtNn8nJCOxba4Jy6OfG74gE
         AsYUb2rScJ6pRrhrBTYHPwJCWqdjJEux3IUnVDD6jly4QQd2+9XnHsGBWXEc6BskoZ1U
         U7UxgApY5W8zmFpLrwubXQaNmqE245HgF8ajyQhizZeY0+OiBRXtnwP/gNiWgCL8KFql
         f4pBeAHRz6YBElVSauHLfUCJpX1k05ujqBc0DO0SM1nxgs+tyhkRIYCJGJNJRAyzya8y
         fC6EC5a/KhNTy7KpxUrrhBzBqOWE6tX9aVge/76kdQzMMjBgLfwYAnQYv1fP9C1+TQ5G
         gGjA==
X-Gm-Message-State: AGi0PuYbZTGOmmbA1zLo9v4E/Ud2VR560RHZqhBIGmznNXOW1R6QTqdz
        UA2KSq+yVhTJnlxiNS3I+uCBJw==
X-Google-Smtp-Source: APiQypJbvYoCtlLR99vFq8QFfkPi/is4ISqtGy6KU3OtHIv7qMauFXBPxAfmsHQ6OBM4mF7H/m1gPg==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr390337wmh.39.1588006215631;
        Mon, 27 Apr 2020 09:50:15 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m14sm21580932wrs.76.2020.04.27.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:50:15 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:50:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] serial: 8250_early: Support earlycon_kgdboc
Message-ID: <20200427165013.yaikxelzilry3eaf@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.9.I8f668556c244776523320a95b09373a86eda11b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.9.I8f668556c244776523320a95b09373a86eda11b7@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:47PM -0700, Douglas Anderson wrote:
> Implement the read() function in the early console driver.  With
> recent kgdb patches this allows you to use kgdb to debug fairly early
> into the system boot.
> 
> We only bother implementing this if polling is enabled since kgdb
> can't be enabled without that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
