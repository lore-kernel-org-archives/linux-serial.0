From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2)
Date: Fri, 12 Sep 2014 20:16:15 +0200
Message-ID: <5413386F.3050903@elproma.com.pl>
References: <1410540563-24789-1-git-send-email-j.uzycki@elproma.com.pl> <CAOMZO5B7EXoJSCxdW4XN7e1iGbY-Jd-z6VCEB2i-CAJyXh-Lrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:57842 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751611AbaILSQT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Sep 2014 14:16:19 -0400
In-Reply-To: <CAOMZO5B7EXoJSCxdW4XN7e1iGbY-Jd-z6VCEB2i-CAJyXh-Lrw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


> On Fri, Sep 12, 2014 at 1:49 PM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
>> Dedicated CTS and RTS pins are unusable together with a lot of other
>> peripherals because they share the same line. Pinctrl is limited.
>>
>> Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
> You meant "AUART controller"
Thanks Fabio. I wait for more comments, especially to comments-questions 
in the code.

best regards
Janusz

