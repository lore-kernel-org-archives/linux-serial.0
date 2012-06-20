From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Wed, 20 Jun 2012 11:16:39 +0200
Message-ID: <CACRpkda_-JNO0o-FqV2n83ae-sszfPyXef73qoZg=2fZc+vfnA@mail.gmail.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
	<20120619003427.GA3114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:40257 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab2FTJQl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jun 2012 05:16:41 -0400
Received: by qafl39 with SMTP id l39so184998qaf.2
        for <linux-serial@vger.kernel.org>; Wed, 20 Jun 2012 02:16:40 -0700 (PDT)
In-Reply-To: <20120619003427.GA3114@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 19, 2012 at 2:34 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 17, 2012 at 03:44:08PM +0200, Linus Walleij wrote:
>>
>> This switches a bunch of allocation and remapping to use the
>> devm_* garbage collected methods and cleans up the error
>> path and remove() paths consequently.
>> (...)
>
> This patch doesn't apply, what tree did you make it against?

It was on top of the patch pending for inclusion into the -rc:s,
I can sure wait for that to be upstream and resend this then,
no hurry.

Yours,
Linus Walleij
