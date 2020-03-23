Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB82C3F2CD
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3E2072D
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584986374;
	bh=2l0KQW4VoP61cJLv+dL28Z9ly7A7laSQG5Iu1ELGiNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2loi5i+33GaBADzvP2QSGCUJevLry0leOk9qseP+XTlyZhtGbhJOmlCqoowMQtM5c
	 G+CohODr70jHeCpaUfg3or3+zQSTpeiNDNcLJraxtysf0SaF6AdodgKR/UeXhdbowB
	 h03R1dQHIkZgCaVEovmNkNlYyFvI5AoHCewTMP+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCWR7b (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgCWR7b (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 13:59:31 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2292076E;
        Mon, 23 Mar 2020 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584986370;
        bh=2l0KQW4VoP61cJLv+dL28Z9ly7A7laSQG5Iu1ELGiNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0lqsb+hyuD6XqDBK/iujiOzptPXvHe2aV/Kkwr/P9PUnDfHuueev3+9fAESyrBbXO
         ZkqqYSoJFuvUWkikxGH/IUJ026YcMeuNlg4tvEn2RHdNtA8m0Q8d/1izBjP/Y7z1YM
         neW0n8jo8z3fJdmpYEmC19DdPkIw8QyaG/UxJ2uQ=
Received: by mail-qk1-f173.google.com with SMTP id x3so4743764qki.4;
        Mon, 23 Mar 2020 10:59:30 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3X6lkENw1D+18PwfR1dHlvEp+svbIONC0IFdXeaX3lh/nmGMJ+
        CfwV5SOwBn319i1jyWmcJbwatv4y65OE6frLzg==
X-Google-Smtp-Source: ADFU+vsR6Us0V+BMyVNelvszRuS/SrM36zlyf95ZYn/ZAx/QRMGOQ3N6czh+WeF4cZMmcFdLqwHXYaDLwzsbRTR1RmQ=
X-Received: by 2002:a37:8502:: with SMTP id h2mr22475590qkd.223.1584986369516;
 Mon, 23 Mar 2020 10:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200320174107.29406-1-lkundrak@v3.sk> <20200320174107.29406-9-lkundrak@v3.sk>
In-Reply-To: <20200320174107.29406-9-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Mar 2020 11:59:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rzaFLvZGX+dpgGhfCSsAvj06T8fcgo83m+ZJGboKsnQ@mail.gmail.com>
Message-ID: <CAL_Jsq+rzaFLvZGX+dpgGhfCSsAvj06T8fcgo83m+ZJGboKsnQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] powerpc/fsl: Make serial ports compatible with ns16550a
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 20, 2020 at 11:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There are separate compatible strings for ns16550 and ns16550a and the
> Freescale serial port is compatible with the latter one, with working
> FIFO.

I don't think changing this is right. First, 'ns16550' is what's
documented in the DT spec (and ePAPR which it's based on).

Second, these dts files are pretty mature/stable, so I'm less inclined
to change them. AFAICT, this change either enables the fifo (which
would be an untested change in behavior) or has no effect because the
fifo is auto-detected.

> Use the appropriate compatible string that is also consistent with ARM64
> Freescale boards and thus avoiding one special case in the binding schema.

Well, that's annoying...

Rob
