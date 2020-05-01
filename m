Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82224C47247
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F675207DD
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRgvttvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEABat (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABat (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 21:30:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DEFC035494;
        Thu, 30 Apr 2020 18:30:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o185so3888797pgo.3;
        Thu, 30 Apr 2020 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49m+qcehWmGfSLUbaZMUYCSNa0kLh4DAVq9qfZtQrY8=;
        b=YRgvttvvqgb3Hwqt0GImFZpZhAeVuFfWnY57qVNB/I1o6iHy464eJL3C1kiJ2JQ5Uj
         0iL7hBEkJOm/XHx8n7J32irNvjOrbA9sFp964DomGNUW15e+NLL8uzekMosBKct9WiX/
         fZ0ieX6ij1cXYM3SjJrwmDpnUP34skvY/kI/nTQp0gHBvM6bsRm1ZdX1GKMwOf17f0uD
         MRvFP7A2gSxW4WYQGnVz3Mq5JQhV7fcgBsxwx3INua5l4ZbTUr5emXo13J2PRHZfFI9G
         tQyLI8vwYoUfhYmnnakVGNcBqx1u4SWjsPacCzE0UZBXQ3Uoo3U1//p04ZWKaWpzc8K4
         KHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49m+qcehWmGfSLUbaZMUYCSNa0kLh4DAVq9qfZtQrY8=;
        b=mtUHSP1xVV+bIkCvmJomZ+h3P0QQU/yS1sqxOgyuByN9BXdg//qkMfDcci3Xn0mF2/
         bJpIKhQVXmofSeXF49UOeun5idzye3/RKf9i8D28yiLJ7VBB8DWKtT4u7UZxCLntszKe
         Y0S9y8FddJNgKlivEECdNTn8SqEcTewQfyBpgqhiRjrqge2Jg1967aXhv4tIEemvrP1t
         yNfYyn54M7m7Vj6Zh6CNnLp6mTjZbdgNQ2xQgit6XNMpErYHQGIc1MOZ9eTUhbKXR/in
         hXfL1dXj1LmL0B5QSWsHnsvvrKDGpsaYG5ftSRC7TJ9s7a3YjVkhPfixlcl/6gY91jsw
         MoLg==
X-Gm-Message-State: AGi0PubmyTmKNs1qBMklrhJGuiLcJmA8bANd8Gqx2gUfOcVAVmlqpdmi
        12SVAeh+3Zbc4ZgzkB8G4LA=
X-Google-Smtp-Source: APiQypKOYGL/38IC+P0JUvU8w6Vlc1XitbcZhxTUNWbIWUNgbgyivZzv9ZUSP1BDO58gaQCrB8XqKw==
X-Received: by 2002:aa7:8e13:: with SMTP id c19mr1688556pfr.260.1588296647317;
        Thu, 30 Apr 2020 18:30:47 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id o40sm804452pjb.18.2020.04.30.18.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 18:30:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 1 May 2020 10:30:44 +0900
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
Message-ID: <20200501013044.GA288759@jagdpanzerIV.localdomain>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/04/30 19:14), Alper Nebi Yasak wrote:
>                     |     "console=tty0"    |    (no console arg)   |
>   ------------------+-----------------------+-----------------------+
>   QEMU VM           | tty0     -WU (EC p  ) | ttyAMA0  -W- (EC   a) |
>   (w/ SPCR)         | ttyAMA0  -W- (E    a) |                       |
>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | ttyS2    -W- (EC p a) |
>   (w/ stdout-path)  |                       | tty0     -WU (E     ) |
>   ------------------+-----------------------+-----------------------+
>   Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
>   (w/o either)      |                       |                       |
>   ------------------+-----------------------+-----------------------+
> 
> This patchset tries to ensure that VT is preferred in those conditions
> even in the presence of firmware-mandated serial consoles. These should
> cleanly apply onto next-20200430.

Well, if there is a "mandated console", then why would we prefer
any other console?

	-ss
