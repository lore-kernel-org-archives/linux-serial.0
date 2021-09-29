Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D84FC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DB06141B
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 18:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbhI2Sh3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2Sh3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 14:37:29 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC8C06161C
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 11:35:48 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id 20so2276413uaj.6
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBCnYGpXpC2TCSqKuPlCeD5q6oFGkUGnusrYSqf3mO0=;
        b=evWOGvCb+Cmi/JcVYf6nXtHun1ho9Mi3/28kQJ9Q6jBGQzopqknGuOMuMe03SBw9uI
         rvTb1MxE5Q7TF3PNE7R9kfOIMn90WmcfM8QNy+rfDorM3HHaBj8fOMJcI38dOhIMVfsO
         xDc9xpOh/9juoyqNbnWl2mIn1M3iNx+c/dw+vkL/vGNnKINrfzoOJFKxw4oTwc5kURZX
         68v11+rmRWsR3usfD3syOmdwQz7VzyxOsvHdxOL7ecE/UlXy+gzCaWU/wby1ctftVMvU
         HmnA+cZbSHtFvHTkC9PeX6AHfwqyKZ8bygoBa1c4wKm0FiHIGaFLak5LJm5VG60fEjT9
         WfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBCnYGpXpC2TCSqKuPlCeD5q6oFGkUGnusrYSqf3mO0=;
        b=rrON+0NTed2yIoz2bh4nqAQ69ETtJFMeY2/0c2cAUN6OafSU8d0qLvYYckiKvHhrhX
         Eu53HkiZWDhDRCijYFCtOt79lqovuGgojlYp9VfY1XWKDlIB1fMot1cRLSZEZoP5BXuJ
         hbluexFYFU/pUceTI3ZD5N5sVRJn0UAjYBjxq0ZqN05mf5hc8C1Hki8AALhJYi8S741r
         46EvbXeBBPOcOXIWLRr+qzwIdtifBBRYIWxd4X5LJYKsvDPAUc7WnZurPcy5yxhuuixV
         8tc0ISHgp5giEEVd/0wk3fh0bN/jgBgiCoAmwrM2xqMiTYLBcW087CAUzN2xKpXHfwWm
         FNJg==
X-Gm-Message-State: AOAM533C0hWDVWxS1KErOJyJK1oEb6wnEbKqxK8jX1lW6G8e+MuOutpm
        nVPjj+yKx48o9A2kMlkZ7/ZzhonIszJC3OkmcDQvJK1DCDg=
X-Google-Smtp-Source: ABdhPJwCPG5SisyPpKkJ/5+2BgttcA4N5Jj3eOjQ/ZSAEMf8375QI/YC0gyMMe6ig4UdESfcX6CCim46UghH9eslEb4=
X-Received: by 2002:ab0:85b:: with SMTP id b27mr1875786uaf.53.1632940547269;
 Wed, 29 Sep 2021 11:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Du1L4A6okC0GJaEiKQr_=n_AJ8SvA15PPU35=mxz8LZw@mail.gmail.com>
In-Reply-To: <CAOMZO5Du1L4A6okC0GJaEiKQr_=n_AJ8SvA15PPU35=mxz8LZw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Sep 2021 15:35:36 -0300
Message-ID: <CAOMZO5DWFttk49W5qP75gOqpXw4HfX0=UU3rsO+y3Xgqdio4fw@mail.gmail.com>
Subject: Re: serial: imx: Possible circular locking dependency
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-serial@vger.kernel.org, rostedt@goodmis.org,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 1:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Petr and Sergey,
>
> I know this has been reported before [1] and [2], but I am still
> observing the deadlock below
> on an imx6q board since commit dbdda842fe96 ("printk: Add console
> owner and waiter logic to load balance console writes").
>
> To reproduce it:
>
> # echo t > /proc/sysrq-trigger
>
> [   20.325246] ======================================================
> [   20.325252] WARNING: possible circular locking dependency detected
> [   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163

If I move the __imx_uart_rxint() block outside the spin_lock() like this:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..c94704f5dd99 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -955,13 +955,6 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
        if ((ucr4 & UCR4_OREN) == 0)
                usr2 &= ~USR2_ORE;

-       if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
-               imx_uart_writel(sport, USR1_AGTIM, USR1);
-
-               __imx_uart_rxint(irq, dev_id);
-               ret = IRQ_HANDLED;
-       }
-
        if ((usr1 & USR1_TRDY) || (usr2 & USR2_TXDC)) {
                imx_uart_transmit_buffer(sport);
                ret = IRQ_HANDLED;
@@ -993,6 +986,13 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)

        spin_unlock(&sport->port.lock);

+       if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
+               imx_uart_writel(sport, USR1_AGTIM, USR1);
+
+               __imx_uart_rxint(irq, dev_id);
+               ret = IRQ_HANDLED;
+       }
+
        return ret;
 }

Then the problem does not happen anymore.

Is this a proper fix?

Thanks
