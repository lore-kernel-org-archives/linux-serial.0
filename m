From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_early: prepare for dynamic BASE_BAUD
Date: Mon, 5 Jan 2015 13:52:33 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307565BC9D66@IN01WEMBXA.internal.synopsys.com>
References: <1420457437-17636-1-git-send-email-vgupta@synopsys.com>
 <1420457437-17636-3-git-send-email-vgupta@synopsys.com>
 <54AA8AFC.9020706@hurleysoftware.com>
 <C2D7FE5348E1B147BCA15975FBA2307565BC9CCD@IN01WEMBXA.internal.synopsys.com>
 <54AA92C7.8070209@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Monday 05 January 2015 07:04 PM, Peter Hurley wrote:
>> Also what do u think of the early IER optimization ?
> Seems ok except the commit changelog is wrong: IER is disabled twice per _line_.
> How did you profile it? It's ok if the answer is "seemed faster"; I'm just
> curious.

Looking at the code yes this would be per line - but I vaguely remember seeing it
for every char - this was when debugging a systemC model for 8250. Its been a while...
I'd added prints in the model whenever IER would wiggle and it was just being
written with 0's again and again when in the early polling based printing mode.

I'll send a revised version with fixed changelog.

Thx,
-Vineet
