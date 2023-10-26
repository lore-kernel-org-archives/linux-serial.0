Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF42C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJZNrS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNrR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:47:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA8187
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:47:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da0737c451cso1683312276.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698328031; x=1698932831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9n8fdUMuomZpDrsqxoqTl0ThgWJwRuU8B75KmpTiCQ=;
        b=MCpUpM7CtFd1Btnkh1HIhaUSCpEnpauHx760oIQliConkLYOX9efKUT96lyZIoWiVZ
         fTVVmVl4xdHL/H5S1eLIavWaW+4vWHHmgtKiKSu899To+qM+s+tgcxNcjoY2VEYmXmoP
         L0lx1M7chS5sMrz6K0xS59X7hRs3uCwpCh0hAvp/ffqQv1E/8fAtE1XcLVLAlfsuKh4v
         RnHok0wD4xBEVbms6KG+lJH+wucy5WAaup5qGuS6OVdRV7qLXIG/MGBSlyyk11tlDN5x
         pTzrOonKfnkDiM5thKG4FDzSTERdbPaHnW2ZQnqt63+svDFc5PAtOcefFz9NUq0/VDvX
         QNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328031; x=1698932831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9n8fdUMuomZpDrsqxoqTl0ThgWJwRuU8B75KmpTiCQ=;
        b=VVRSDyvZLq77q7SYQkJDuTbn5Yljm2ZVVEoFzLTFT1i5Tl4rJMO2XCFDyzUH1cGVnK
         QMhf2h40qt5cYR+NIDi20s+qQnRab/eYr5gdd+3qkNFarUABr3gQLJaQxGCLajCvmWOI
         tkD55d6/E1e+lCpcKexmo2oqWkkdF9tQsWDZA0bn+Wv7al4O7yFHpuB2b0BHMuhvRkQ1
         GbvtA6FoWdcwFH3jfS8qXkf0HPerlFK7gNvABtfTDhQMfQpf3+bU1Z3vTGxzhsbSgOxj
         0k7dNkTTEN1wYN5KAKdL6bbMSZFbZatX2wetLj02SHKP6vUTp6MNA/GztxDZOHzaRsfa
         nGng==
X-Gm-Message-State: AOJu0YwmDDwJEPRJAne4+N4XMKKGsDoSBkz3BkYNhG1DlB28262/oIel
        +bABcOnc7X+Hb4E+tqCheR92uETqtjgT1epy5wsRxw==
X-Google-Smtp-Source: AGHT+IGzqfAtuY+CnvRNbJPNwqa8xrhztIhzvjmFd68cerFhlPPGEGhTxQKguYR027QteX+t5yUAkIEXGQBA9Orufqc=
X-Received: by 2002:a5b:8c5:0:b0:da0:3ec1:f3f with SMTP id w5-20020a5b08c5000000b00da03ec10f3fmr5401782ybq.3.1698328029846;
 Thu, 26 Oct 2023 06:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-5-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-5-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:46:58 +0200
Message-ID: <CACRpkdbLqB29gMHYU2sT=3VD6XuOeaFSAdO2=qDS+=KCBi0jPA@mail.gmail.com>
Subject: Re: [PATCH 5/6] tty: serial: amba-pl011: unindent pl011_console_get_options
 function body
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> The whole function body is encapsulated inside an if-condition. Reverse
> the if logic and early return to remove one indentation level.
>
> Also turn two nested ifs into a single one at the end of the function.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
