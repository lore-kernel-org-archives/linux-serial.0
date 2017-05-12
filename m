From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Fri, 12 May 2017 10:11:29 +0900
Message-ID: <20170512011129.GA4020@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170511113220.GA11507@jagdpanzerIV.localdomain>
 <e757047d-d40a-582b-7c50-b8d8f93a076e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e757047d-d40a-582b-7c50-b8d8f93a076e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

On (05/12/17 00:17), Aleksey Makarov wrote:
> On 05/11/2017 02:32 PM, Sergey Senozhatsky wrote:
> > On (05/11/17 17:41), Sergey Senozhatsky wrote:
> > [..]
> > > Alexey,
> > > can we have preferred console at offset 0 (not at console_cmdline_cnt - 1)
> > > and restore the previous register_console() iteration order?
> > 
> > btw, what if someone has configured the system as
> > console=   non-braille non-braille braille non-braille?
> > "The last non-braille console is always the preferred one"
> > is not true in this case.
> 
> I don't quite follow what you think is problem here.

please ignore it, just a long day at the office. sorry.

	-ss
