Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFCC25B67
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjJZNqe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNqd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 09:46:33 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCBBCC
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:46:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so527750fac.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698327989; x=1698932789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdyVVw0aBVMHPJpP77t0JsBJNKlhvsWo73t+NTi0GM8=;
        b=zSCLn1Xx3oirlDQLkV2dktoqiTTgCLUIjAUgiWgiQx36E6M67EdgwqaKpP7woCRjAh
         +piQKOs89247vNn960XRCU5hNc96TSfqzJXAh2HkU2cLdypASINfZPVqq+7xL/6a3nsb
         47mpF+gK2kGXVktz/gS6kOopKcwn1L7iDPlU8lERtUF0z6evcATShynlw6K2NTmjnqb6
         J3jugKPopMNl5oAO5vlNmrO4w/ZgTl1vaBWL6wNDtuyQE9yz7/0FfN1JEQUjj3KfOeK8
         gTdNXefDkH76n5ax50NUM2jEDb+UcA61ogFp1p0VxMRRzbjvFVKEKsuOW4Nt0vXqcez1
         ZUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327989; x=1698932789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdyVVw0aBVMHPJpP77t0JsBJNKlhvsWo73t+NTi0GM8=;
        b=a7M6hhYee4OI7+VKAkvQiMnRyqmjEjpyeH1NcnPWzA8KXSk4B0QcfU2yrSPkiGg2JW
         zDauMfpL7udi33chgXZNpzvXxHCBhb/cgqybmaHD/wLua/Pqo1rck7SYseiJwPu12uuL
         OHdnIcFtz/Ko3g4vGbE600nh5elNHKgNEWqj72xLCkUxvD5qjL/kNx6hkQHs9CWYDK8/
         +dHluqAa/J9E+L7V6p46S/G+Ru5MUoqUOxur/jCGrCXFZqi6sJo2NkOPds6w+/YRqZ6o
         UpGUZ207g0EH9Z+RypFqO4A9BjwYzTY5MO+Xzrxcqgs9gdonymvW7fNWuOoZ4w+SBRII
         P7ow==
X-Gm-Message-State: AOJu0YxUCODWb8oPW/3JGqaRF0sd3G97t09Hr3Z2ZnnFnsPG0dUFOdSp
        sX3qmvpEtONpfReja2pGb5C88Q3cTgLGEekHujpBbw==
X-Google-Smtp-Source: AGHT+IG7t8B3P3kKeLg6CoQvDuqK9LBfIdNsKeqT9G9yoMJXpb7eWsJTzdRDKDCS3Xpwgm9anaN/0YyEZAjEQDYjsrk=
X-Received: by 2002:a05:6870:7a1b:b0:1e9:f0be:cbbe with SMTP id
 hf27-20020a0568707a1b00b001e9f0becbbemr24209376oab.9.1698327989467; Thu, 26
 Oct 2023 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:46:18 +0200
Message-ID: <CACRpkdZRW6Evzr+CWuhpz6hinfAnwXaEp4GG=9+zY6yJy14xmw@mail.gmail.com>
Subject: Re: [PATCH 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
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

> The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
> simplify the logic. Those look scary to checkpatch because they contain
> ifs without do-while loops.
>
> Avoid the macros by creating small equivalent static functions; that
> lets the compiler do its type checking & avoids checkpatch errors.
>
> For the second instance __assign_bit is not usable because it deals with
> unsigned long pointers whereas we have an unsigned int in
> pl011_set_mctrl.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

The kernel looks better after this patch than before, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Since the eternal defines uses masks rather than bits we can't
use __set_bit() & friends in this case and that's life.

Yours,
Linus Walleij
