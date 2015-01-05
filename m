From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_early: prepare for dynamic BASE_BAUD
Date: Mon, 05 Jan 2015 09:05:41 -0500
Message-ID: <54AA9A35.2000806@hurleysoftware.com>
References: <1420457437-17636-1-git-send-email-vgupta@synopsys.com> <1420457437-17636-3-git-send-email-vgupta@synopsys.com> <54AA8AFC.9020706@hurleysoftware.com> <C2D7FE5348E1B147BCA15975FBA2307565BC9CCD@IN01WEMBXA.internal.synopsys.com> <54AA92C7.8070209@hurleysoftware.com> <C2D7FE5348E1B147BCA15975FBA2307565BC9D66@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307565BC9D66@IN01WEMBXA.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On 01/05/2015 08:52 AM, Vineet Gupta wrote:
> On Monday 05 January 2015 07:04 PM, Peter Hurley wrote:
>>> Also what do u think of the early IER optimization ?
>> Seems ok except the commit changelog is wrong: IER is disabled twice per _line_.
>> How did you profile it? It's ok if the answer is "seemed faster"; I'm just
>> curious.
> 
> Looking at the code yes this would be per line - but I vaguely remember seeing it
> for every char - this was when debugging a systemC model for 8250. Its been a while...
> I'd added prints in the model whenever IER would wiggle and it was just being
> written with 0's again and again when in the early polling based printing mode.

Maybe that was while running kgdb through serial8250_put_poll_char(), which is
per-char.

Regards,
Peter Hurley
