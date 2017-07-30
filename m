From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/5] earlycon hang under some conditions
Date: Sun, 30 Jul 2017 17:31:03 +0300
Message-ID: <CAHp75VdHqD67jcoaQ5EwdTVdoyLNF0DCTQDvTxWikiaOnPs75g@mail.gmail.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-snps-arc@lists.infradead.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 9:02 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> I was testing earlycon with 8250 dw serial console. And it hangs in
> these cases:
> 1/ kernel hang when calling early write function after free_initmem:
> a) the earlycon not disabled after the init code(due to keep_bootcon or
>    not specify a real console to switch to)
> b) the early write func is marked as __init, for example 8250_early.

> This serial fix 1/ case only.

Here is another opinion.
I can tell that conditions to get into the trouble are quite unusual or rare.

Any rationale behind why one needs such a combination of parameters?

P.S. For doulble output ask Sergey and Petr (they are quite concerned
about it). Actually strange I didn't see their names in Cc list for
console related stuff,

-- 
With Best Regards,
Andy Shevchenko
