From: Mark Roszko <mark.roszko@gmail.com>
Subject: Re: [RFC PATCH] tty/serial: at91: disable uart timer at start of shutdown
Date: Wed, 8 Jan 2014 09:29:31 -0500
Message-ID: <CAJjB1q+0cMqGRX8e5ssvvvo1pSw4KY7n38vWOh-PnE8GRC2Pug@mail.gmail.com>
References: <CAJjB1qLBoXA_XeEV+qU6pi0JVS+==kVA7mEDuAufrYup3htU2g@mail.gmail.com>
 <1389176916-6114-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389176916-6114-1-git-send-email-nicolas.ferre@atmel.com>
Sender: stable-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Zhao, Leilei" <leilei.zhao@atmel.com>, Mark Deneen <mdeneen@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

**Sorry for the duplicate mail, I forgot to force plain-text mode in
gmail or the mailing list rejects the mails. Sigh, I need to buy my
own email server at this rate to even deal with the mailing lists and
proper etiquette (no quoteS) :(

Ah, I forgot there was that third mode(no dma and no pdc). Yea it's
probably a bad idea to play with fire and call del_timer_sync on a
non-initialized timer struct.

Alternatively to setting it up in all modes, the mode could also be
checked in _shutdown:
if ( ( atmel_use_dma_rx(port) || atmel_use_pdc_rx(port) )
           && !atmel_port->is_usart)
      del_timer_sync(&atmel_port->uart_timer);

But it doesn't hurt to call setup_timer in the other case either
because it just initializes the fields in timer_list. So I'm not sure
what best practices dictates here.

Commit messages looks fine, thanks for fixing that, I'm still getting
used to the linux dev process and I also do it at 3am at night.
