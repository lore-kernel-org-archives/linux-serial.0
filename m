From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2]: serial8250: Use native_io_delay on the x86
Date: Wed, 17 Mar 2010 11:43:54 -0700
Message-ID: <4BA122EA.9030305@zytor.com>
References: <20100317132849.7d49939b@marrow.netinsight.se>	<20100317133050.54851ff8@marrow.netinsight.se>	<4BA11EAA.20506@zytor.com> <20100317183608.600bcdf0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41731 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab0CQSos (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 14:44:48 -0400
In-Reply-To: <20100317183608.600bcdf0@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Simon Kagstrom <simon.kagstrom@netinsight.net>, x86@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, alan@linux.intel.com, akpm@linux-foundation.org

On 03/17/2010 11:36 AM, Alan Cox wrote:
>
> You just need a write to something on the ISA bus which is 'safe' so that
> you don't end up reading back what you wrote to an non-existant port as
> some old chipsets will return the last ISA result when you do this rather
> than 0xff.

Ah... floating bus syndrome.  So how about writing 0xff to the SCR 
register in the same register range?

	-hpa
