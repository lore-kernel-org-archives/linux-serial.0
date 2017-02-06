From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from
 8250_pci
Date: Mon, 6 Feb 2017 15:06:16 +0100
Message-ID: <20170206140616.GA9872@kroah.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
 <d77cf226-a1bc-0f55-9f2b-af6a97f2f74b@siemens.com>
 <5894F6A2.5000609@gmail.com>
 <1a0e4034-007e-d5cf-27ff-eb382ead776e@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a0e4034-007e-d5cf-27ff-eb382ead776e@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 06, 2017 at 02:49:07PM +0100, Jan Kiszka wrote:
> On 2017-02-03 22:31, Sudip Mukherjee wrote:
> > On Friday 03 February 2017 02:02 PM, Jan Kiszka wrote:
> >> BTW, are you personally the copyright holder or your employer Codethink?
> >> Depends on your contractual situation, but the former is less common.
> > 
> > Well, Codethink has nothing to do with this patch. This was a voluntary
> > work started before I joined Codethink, but then I joined Codethink and
> > found very little time to finish this. So finally now its done.
> > 
> > https://lists.kernelnewbies.org/pipermail/kernelnewbies/2015-November/015372.html
> > 
> 
> Hmm, why using your corporate email address then? This suggests a
> different copyright situation.
> 
> Funnily, I just received this question internally: How can you tell
> apart if someone sends a personal contribution via his/her employer
> account from someone contributing on behalf of a company, thus with that
> company holding the rights? I argued that no one would do the former to
> prevent wrong accounting, but you just proved a counterexample. :)

There are numerous companies that do this, some create whole shell
orginizations in order to "hide" their kernel contributions for various
"interesting" reasons.

Fun stuff.  I suggest having your internal people talk to your lawyers,
they should know all about this (and if not, have those lawyers talk to
the LF lawyers...)

But that's not the issue here, we know Sudip :)

thanks,

greg k-h
