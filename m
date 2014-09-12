From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2)
Date: Fri, 12 Sep 2014 14:05:11 -0300
Message-ID: <CAOMZO5B7EXoJSCxdW4XN7e1iGbY-Jd-z6VCEB2i-CAJyXh-Lrw@mail.gmail.com>
References: <1410540563-24789-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:40076 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaILRFN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Sep 2014 13:05:13 -0400
In-Reply-To: <1410540563-24789-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Sep 12, 2014 at 1:49 PM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
> Dedicated CTS and RTS pins are unusable together with a lot of other
> peripherals because they share the same line. Pinctrl is limited.
>
> Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,

You meant "AUART controller"
