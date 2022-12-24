Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFB2C4332F
	for <linux-serial@archiver.kernel.org>; Sat, 24 Dec 2022 20:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiLXU5l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Dec 2022 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXU5j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Dec 2022 15:57:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360382CC
        for <linux-serial@vger.kernel.org>; Sat, 24 Dec 2022 12:57:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bf43so11366872lfb.6
        for <linux-serial@vger.kernel.org>; Sat, 24 Dec 2022 12:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BNeoLNNaOmsevMGUvUd6gMJHIInI3zsd3bgrIWw4DSw=;
        b=e4nE0bdOtt98ELRyAsKBNYMZLlBlZ6mYPfcw3ifmvzlhKJXupa2usuVbRF7Ik3bBoA
         UXzQH1s+16zr7WAVPR//TTvAf2FjRGll4qleMZUkJdbzWMhEliS6bwS4oUxIerGwEPAO
         fcxDN9ndx2V3p5eke03AYVQf4rbT8OnHgiTiJ39vIUsmNd5EmI+i0DhH6rxVz/rP7PSb
         j04Xa9JhIsCx7QhMR9NUTMcSRc/XA5tqJV8kll4hWFzJWxYN+4QHm4eFB1PEElLyc39w
         RYelSwhGLfM27l0kbIIYKd6WxIisqD3nInDENpofULd8uK0XQzDazDUSkblC1htNaVKA
         HQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNeoLNNaOmsevMGUvUd6gMJHIInI3zsd3bgrIWw4DSw=;
        b=aNVVTrN1GVZvyCyCBHGRM/6NC0VaA72Gcbme8G3a59dKcBJxKngWEZcnmiLp0KzeL3
         2mTW4mtwgjoNACsr83TOIV8iWNkh746rdAu3PVcnMpotwOGpK0IAsMn4LIj0tF5v4i7e
         X92dq71pUSCeYUZUsh26IXtg4JxPBko1OPpE/x4hLGNjgpjMEWwrRLpKKbZ2+bDujpfg
         8+tsgRoh2gRCM4JHEQH2OE+2JGL3dMif/1AfxanKLJw6HZmtY7W8M+i4basFvoukilQa
         qzEw9c8EDeeXdo+VO61525GGstwNddcUdCng4sOGYdWiw6JADisGWwpQkUDWRsRduMBL
         CMOg==
X-Gm-Message-State: AFqh2kocYBLkFAza8MmLQE3W6lC0CjlUito9ko1okZVbcQMZqeJzhtOJ
        C2RbI2ClRXbOnZSi3Kof9Ho=
X-Google-Smtp-Source: AMrXdXuOXc12XxVXeYzQi0a8SCxu1sL1j2qUltVZMZHh5+ul9KQPwH5yHxRxJEQmK7O8SqunxSm3EA==
X-Received: by 2002:ac2:4bd3:0:b0:4a4:68b7:d638 with SMTP id o19-20020ac24bd3000000b004a468b7d638mr3858914lfq.31.1671915456333;
        Sat, 24 Dec 2022 12:57:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j1-20020a056512344100b00498f23c249dsm1081257lfr.74.2022.12.24.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 12:57:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Anton Bondarenko <anton_bondarenko@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: serial: imx: doubtful code?
Date:   Sat, 24 Dec 2022 23:57:34 +0300
Message-ID: <87ili08qpt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I'm to implement a work-around in the driver to stop 0xff flood caused
by malfunction of the hardware, and I got a few doubts when looking at
the code. I'd appreciate any insights on the issues below.

1. URXD_DUMMY_READ bit logic introduced to handle CREAD[1] slightly gets
in the way of implementing the work-around. I wonder why do we need
URXD_DUMMY_READ in the first place? Why don't we just disable receiver
in hardware by clearing UCR2_RXEN bit when CREAD is not set in termios?
Any specific reason for that? Is it a requirement that we still do read
everything from hardware, so that sender can't notice CREAD is cleared
on our side, or what?

2. URXD_DUMMY_READ forces break from FIFO reading loop on the first read
char, at imx.c:850. This seems to achieve nothing positive, yet it risks
to cause either needless isr re-entries, or leaving some stuck chars in
the FIFO waiting for URXD_DUMMY_READ to be cleared. Is it OK to
continue FIFO reading (and still ignoring the chars) instead?

3. Related to (2), yet another instance of code that checks for bits to be
ignored does break from the FIFO loop as well, but only after 100 chars
has been ignored at this run, at imx.c:831. This looks like protection
from something, but what's that, and how it'd protect from anything by
just exiting the loop? Don't we then need something more drastic like
disabling some IRQs or resetting the chip? It looks even more suspect as
this is the only place in the loop with such "protection". OK to get rid
of this suspect check?

4. uart_handle_sysrq_char() is called before error bits are checked, at
imx.c:817. Do we really need to consider potentially random characters
as sysrqs, and are we safe doing this? Would you support a change to
pass only cleanly received chars to sysrq?

5. imx_uart_clear_rx_errors() that is used on DMA path seems to never
considers IGN* flags: instead it always inserts BREAK, and never
OVERRUN, PARITY, or FRAME. There are no comments in the code. What's
going on here?

6. Related to (2), __imx_uart_rxint() checks USR2_BRCD in the loop when
it also has two checks for URXD_BRK later in the same loop. This
handling looks rather convoluted, yet no comments in the code are
provided. It looks like USR2_BRCD check could be at least moved out of
the loop, if not removed in favor of doing all that is needed in
URXD_BRK check.

7. __imx_uart_rxint() reads USR2 two times for every char when one time
seems to be enough. We can likely get even to zero USR2 reads, provided
we rather use URXD_CHARRDY to terminate FIFO reading loop, and get rid of
USR2_BRCD check (see (6) above). Worth to optimize?

References:

[1] URXD_DUMMY_READ has been introduced by:

"
commit 55d8693acd65b1c14e011cbcbfad2a15626472cd
Author: Jiada Wang <jiada_wang@mentor.com>
Date:   Tue Dec 9 18:11:22 2014 +0900

serial: imx: add CREAD flag support

Add CREAD flag hanlding in set_termios and UART DMA mode
which ignores all received chars when CREAD flag cleared.
"

Thanks,
-- Sergey Organov
