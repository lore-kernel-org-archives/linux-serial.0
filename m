Return-Path: <SRS0=pW61=AQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2882AC433DF
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7E4207CD
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593944939;
	bh=ywDYyYP83zj9ux21PYQE5OrCn1bZz2ia8i+WucARUgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q/AAfgzftTcec5NtzVEoSImfaq8IXQpDzcffSsBfrRCM6pjWmHHRBlJA7fRV6qlmr
	 6BizghCN3tHjhz9JHoKMQKRN95P4Bk2pidawojE3RhvZ7Fn3XjGS7LFWnLikTwizKE
	 l4Fx5wkweLZVk/tUbkiRczvi4G5UDPYsqsGuCUuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGEK27 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgGEK27 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Jul 2020 06:28:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C7320786;
        Sun,  5 Jul 2020 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593944938;
        bh=ywDYyYP83zj9ux21PYQE5OrCn1bZz2ia8i+WucARUgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5ugYCRcCIJ50y0MU+Z52rDKvhA5WMAhemEVnI4a1zRjeJkTWZ8WWI83NNCF0tVqg
         yZpQSUpFsTR16EKSAFVK2prnFxnoms/90vCmG3JEA5h+PvYzgn8V4GUC6t0rr6yi1p
         Ec+o8vL7a9Eb1lh8YklF6VIOGDSeqa9Ss+QELlZM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1js1tI-0099z3-TV; Sun, 05 Jul 2020 11:28:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 Jul 2020 11:28:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] tty: serial: meson_uart: Init port lock early
In-Reply-To: <CAHp75VfFNO=oqHX9EeNdVgcQUfu7RBr6SDTWi3XF4gSQNjqzUw@mail.gmail.com>
References: <20200705092736.1030598-1-maz@kernel.org>
 <CAHp75VfFNO=oqHX9EeNdVgcQUfu7RBr6SDTWi3XF4gSQNjqzUw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <66dcb907f3b9c5413cebe14e0bec00a4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, khilman@baylibre.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, andriy.shevchenko@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-07-05 11:07, Andy Shevchenko wrote:
> On Sun, Jul 5, 2020 at 12:32 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> The meson UART driver triggers a lockdep splat at boot time, due
>> to the new expectation that the driver has to initialize the
>> per-port spinlock itself.
>> 
>> It remains unclear why a double initialization of the port
>> spinlock is a desirable outcome, but in the meantime let's
>> fix the splat.
>> 
> 
> Thanks!
> 
> Can you test patch from [1] if it helps and doesn't break anything in 
> your case?
> 
> [1]:
> https://lore.kernel.org/linux-serial/20200217114016.49856-1-andriy.shevchenko@linux.intel.com/T/#m9255e2a7474b160e66c7060fca5323ca3df49cfd

On its own, this patch doesn't seem to cure the issue (and it
adds a compile-time warning due to unused flags).

Or did you mean to test it in complement of my patch?

         M.
-- 
Jazz is not dead. It just smells funny...
