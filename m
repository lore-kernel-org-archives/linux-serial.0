Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353EC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6ED6121E
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 07:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhDLHbm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhDLHbH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 03:31:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57403C061574;
        Mon, 12 Apr 2021 00:30:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id n4so10146225ili.8;
        Mon, 12 Apr 2021 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brKZsiOT6iIS0G8tmBOgDjnt2x9imG0kYyprBpVpTOg=;
        b=rwwCdvqyl4Wz7vUHGh+mfhsanlEviCTu7nRg7RKgmFB/dbMALPvHXCYVQK6YNQQkqR
         svrd9Lyvw7IYqfBiW6uwb8PyV7KMd09FkUyPjlw8Z/Y7wQ/L1Rc5qnlzop5O+/TkP6oI
         aBxuqmXushzZPZKNsaic7KD2FNaltCDTYbo+/UWJRX5LAL+EZbNZJ/tB33SqJWrMh/0j
         i/rxUSV0TojX96fChZZwevhrDlEPCHRamQt/q9Dk6CJO/eOGZD3kZ99DGOXKYHuMMDF5
         3w/0ey2+FZTuZd8mfZXg53dp2yvJyddB3khN8ApR7oDaeRKnKn6am+HFS/pj8tW176XY
         5hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brKZsiOT6iIS0G8tmBOgDjnt2x9imG0kYyprBpVpTOg=;
        b=tu17FyWUvMW2HvY7nGey9vhUi3vWOjBKPnm/IT3+CRsGShIaHZJuXuN2Ns+jcgBfcG
         TVoCcYkY9RmLX7RDf/mf5aa19TfIy+yHQTRR2ZqaHDkahwhVaYkVZ9y3ERb2h/K6kUzq
         6HSexkHT0k0eZHcw1ZWcPYZTV+6PO73MJ1YEhEREGXW96gKtbNxr+S39K9uco9u3pm+7
         JZBpTYe2FYhh8tvHPfii34E5cOJCMKS6Bdaoe/F1kHk7gb70wg6sz/OxdYltsfFmus8F
         wsiDfb7qLXrjZzSQLL6rd47vjWqnD772SdmEMyOvMRIVv4mnLDwqscFQWCv0nrr4w8/2
         /CUw==
X-Gm-Message-State: AOAM533hvElIvZsHybI3+hSaLTASLWIcZVPxYRzB3ZCgRCtHSTTWLUMQ
        yo+7bOGxVaY9VcShTvIeOlQLDk1S84zsbf1DshA=
X-Google-Smtp-Source: ABdhPJwxS/0Ij0eJ2IB0VLfPau/min812MYl8pT0ZdhTDlXX0F6uUoluIQRbp0u+Ry0Qt6ZgUSYh5AjaWYpPvpXPdCU=
X-Received: by 2002:a05:6e02:1809:: with SMTP id a9mr1366918ilv.184.1618212626339;
 Mon, 12 Apr 2021 00:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com> <202104121526.gm7LWDAv-lkp@intel.com>
In-Reply-To: <202104121526.gm7LWDAv-lkp@intel.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 12 Apr 2021 15:29:50 +0800
Message-ID: <CAL9mu0LDi2-aAU=cGDhBb6fkxWRKUNeRXcR-q1snJERm5ju=QQ@mail.gmail.com>
Subject: Re: [PATCH] serial: stm32: optimize spin lock usage
To:     kernel test robot <lkp@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi lkp,

Thanks for the reminder.
I just noticed this from greg's mail. still waiting for his response
about the proper solution for this patch.
After that i will update version 2 for it.

Your test is really efficient, thanks.

Best regards,

Dillon.

On Mon, Apr 12, 2021 at 3:25 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on stm32/stm32-next]
> [also build test WARNING on usb/usb-testing v5.12-rc7]
> [cannot apply to tty/tty-testing next-20210409]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/dillon-minfei-gmail-com/serial-stm32-optimize-spin-lock-usage/20210412-123607
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> config: riscv-randconfig-r034-20210412 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9829f5e6b1bca9b61efc629770d28bb9014dec45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/a0e81ae10c46f768437d61cd3a3dfd4d1250b375
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review dillon-minfei-gmail-com/serial-stm32-optimize-spin-lock-usage/20210412-123607
>         git checkout a0e81ae10c46f768437d61cd3a3dfd4d1250b375
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/tty/serial/stm32-usart.c:280:39: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]
>                    spin_unlock_irqrestore(&port->lock, flags);
>                                                        ^~~~~
>    drivers/tty/serial/stm32-usart.c:217:24: note: initialize the variable 'flags' to silence this warning
>            unsigned long c, flags;
>                                  ^
>                                   = 0
>    1 warning generated.
>
>
> vim +/flags +280 drivers/tty/serial/stm32-usart.c
>
>    211
>    212  static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>    213  {
>    214          struct tty_port *tport = &port->state->port;
>    215          struct stm32_port *stm32_port = to_stm32_port(port);
>    216          const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>    217          unsigned long c, flags;
>    218          u32 sr;
>    219          char flag;
>    220
>    221          if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
>    222                  pm_wakeup_event(tport->tty->dev, 0);
>    223
>    224          while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
>    225                                        threaded)) {
>    226                  sr |= USART_SR_DUMMY_RX;
>    227                  flag = TTY_NORMAL;
>    228
>    229                  /*
>    230                   * Status bits has to be cleared before reading the RDR:
>    231                   * In FIFO mode, reading the RDR will pop the next data
>    232                   * (if any) along with its status bits into the SR.
>    233                   * Not doing so leads to misalignement between RDR and SR,
>    234                   * and clear status bits of the next rx data.
>    235                   *
>    236                   * Clear errors flags for stm32f7 and stm32h7 compatible
>    237                   * devices. On stm32f4 compatible devices, the error bit is
>    238                   * cleared by the sequence [read SR - read DR].
>    239                   */
>    240                  if ((sr & USART_SR_ERR_MASK) && ofs->icr != UNDEF_REG)
>    241                          writel_relaxed(sr & USART_SR_ERR_MASK,
>    242                                         port->membase + ofs->icr);
>    243
>    244                  c = stm32_usart_get_char(port, &sr, &stm32_port->last_res);
>    245                  port->icount.rx++;
>    246                  if (sr & USART_SR_ERR_MASK) {
>    247                          if (sr & USART_SR_ORE) {
>    248                                  port->icount.overrun++;
>    249                          } else if (sr & USART_SR_PE) {
>    250                                  port->icount.parity++;
>    251                          } else if (sr & USART_SR_FE) {
>    252                                  /* Break detection if character is null */
>    253                                  if (!c) {
>    254                                          port->icount.brk++;
>    255                                          if (uart_handle_break(port))
>    256                                                  continue;
>    257                                  } else {
>    258                                          port->icount.frame++;
>    259                                  }
>    260                          }
>    261
>    262                          sr &= port->read_status_mask;
>    263
>    264                          if (sr & USART_SR_PE) {
>    265                                  flag = TTY_PARITY;
>    266                          } else if (sr & USART_SR_FE) {
>    267                                  if (!c)
>    268                                          flag = TTY_BREAK;
>    269                                  else
>    270                                          flag = TTY_FRAME;
>    271                          }
>    272                  }
>    273
>    274                  if (uart_handle_sysrq_char(port, c))
>    275                          continue;
>    276                  uart_insert_char(port, sr, USART_SR_ORE, c, flag);
>    277          }
>    278
>    279          if (threaded)
>  > 280                  spin_unlock_irqrestore(&port->lock, flags);
>    281          else
>    282                  spin_unlock(&port->lock);
>    283
>    284          tty_flip_buffer_push(tport);
>    285
>    286          if (threaded)
>    287                  spin_lock_irqsave(&port->lock, flags);
>    288          else
>    289                  spin_lock(&port->lock);
>    290  }
>    291
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
