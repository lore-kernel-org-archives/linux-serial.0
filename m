Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92556C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiJZTSk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiJZTSi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 15:18:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A76CD1E
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 12:18:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b2so30791320lfp.6
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=508uESUJQQlsUnNE8BOBdjcSNZ1CllqIWsbhRhRwhew=;
        b=BhPjpjtaEUstfwivj8SXsEt3RdnsOf2WfRs1ShzXI8SErjS/ZZ+NUGTDDqAIquDDHQ
         T5iaYib5cAaOiirDPlyaXBk4jtKo1IbcaRe5I/iJWTfbEfYLNFPlGbsdYZtvE4wv4lLW
         j3MJNuHHb1yI6wGOMpWbyiH4rhmh4qKvx12drPKcffFhxKSYPCP6c/w562ReCOGTs7PQ
         w2yukwt24c1xaza6Yf2IjpbTVPuUPA5q5QFe9IqvUFp1XmknSu+xa0XLlkd6bSBdKMRs
         cI6m/mxA4Y9LFCsVMqe8i4tIMUWM10bhq4qR+fgdSU2uOtJlNrMZXQUQgcY0ZL/56baA
         mBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508uESUJQQlsUnNE8BOBdjcSNZ1CllqIWsbhRhRwhew=;
        b=pqsx7vbZdcoCdczxW6bPbIOzOltF34imoeLJVDxj5MzmYhNKUEEpuydFo7AUBKTQ0/
         8InakkM7+0NFsXZqiKicUcAVy0LPmLJcL+PZF4k+A2iqZOGbxmEHmCe345Ro1bvUsBeB
         IihBgIbewaF4S6ti/ZISatncgLPckWBtMrixqcneud9+VS0ZmqWq0tpNJLm/VWAOStN/
         NcyLlY+nYmjqyx1DJPCYFEKo7DR7eIr6fumOOI1utTMZ9ESmTocmXw95p2ENNRKUwpXE
         nqYNhDf84OtYSrrH3p4GoSYHgDQF9JL46yw6ghhpcVwDwq8zcfb40A7SPDa6xKpZUudG
         NWTw==
X-Gm-Message-State: ACrzQf21enps8GjFLgNhWucy/Hi1rnxamuWe7CfbU1APo3iY8DDkgvhw
        nm0yIl59pMHAEr9Q53NtqVw=
X-Google-Smtp-Source: AMsMyM7xQh484oYCdzm5Q0gjdBbcxVOA66t5wxdePGJBT9gKb232/btXxxxGBVItSQ47oAT7mt+1pA==
X-Received: by 2002:a19:7709:0:b0:4a4:769c:fccb with SMTP id s9-20020a197709000000b004a4769cfccbmr18465135lfc.356.1666811913347;
        Wed, 26 Oct 2022 12:18:33 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z20-20020ac25df4000000b004a2386b8cf4sm936976lfq.258.2022.10.26.12.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:18:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: imx serial chars lost issue
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
        <CAOMZO5BWUrFWyLFo8X=TfOBtoc6U0vNYR3k7wPNcVXd93q+Wjg@mail.gmail.com>
        <Y1jihi+8L4ctFO9B@francesco-nb.int.toradex.com>
Date:   Wed, 26 Oct 2022 22:18:31 +0300
In-Reply-To: <Y1jihi+8L4ctFO9B@francesco-nb.int.toradex.com> (Francesco
        Dolcini's message of "Wed, 26 Oct 2022 09:32:22 +0200")
Message-ID: <878rl2bdh4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Francesco Dolcini <francesco@dolcini.it> writes:

> On Wed, Oct 26, 2022 at 12:06:34AM -0300, Fabio Estevam wrote:
>> Hi Francesco,
>> 
>> On Mon, Oct 3, 2022 at 8:08 AM Francesco Dolcini
>> <francesco.dolcini@toradex.com> wrote:
>> >
>> > Hello all,
>> > recently I have been experiencing an issue with the imx uart on i.MX6ULL
>> 
>> Does this also happen with other i.MX devices or only on i.MX6ULL?
>
> I do not know for sure, I did not try to actively reproduce the issue on
> another SoC. On the other hand the issue with the i.MX6ULL was noticed
> during some testing, and we do exactly the same tests on other SoC and
> there the issue is either not present or just happening very
> infrequently.
>
>> > SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
>> > are lost when typing "fast" (copy/paste or writing to the uart using
>> > automated tools).
>> >
>> > This was tested on Linux 6.0, however it does not look like a brand new
>> > regression, kernel 5.4 was somehow subject to the same issue, although
>> > it was way more difficult to trigger it.
>> >
>> > While I do understand that without flow control this is something that
>> > cannot be prevented, it is pretty fishy that is always the chars after
>> > the 32nd.
>> >
>> > I guess that might be happening is that the FIFO is emptied only by a
>> > timer or when it is full, instead of emptying it when half-full, and the
>> > CPU might not be fast enough leading to an overflow and the chars lost.
>> >
>> > Any idea?
>> 
>> Can you share a reproducer?
>
> Just open the uart console with a terminal application and copy/paste the
> following:
>
>  echo -n "12345678901234567890123456789012345678901234567890123456789012345678901234567890" | wc
>
> This is supposed to count 80 chars, you'll get less.

I've tested this on my board featuring iMX6SX CPU, using socat on both
ends of the serial line:

On PC, using MOXA multi-port serial board:

$ echo -n "12345678901234567890123456789012345678901234567890123456789012345678901234567890" |  socat - /dev/ttyMI3,cfmakeraw,b115200

while running

$ socat -u /dev/ttymxc5,cfmakeraw,b115200 ./log

on the board, and I got exactly 80 bytes in the ./log.

The kernel running does not contain mentioned 7a637784d517 ("serial:
imx: reduce RX interrupt frequency") though, so maybe it's just that.

-- Sergey Organov
