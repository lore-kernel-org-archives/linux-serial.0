From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] serial/arc-uart: switch to devicetree based probing
Date: Sat, 9 Feb 2013 09:28:43 +0000
Message-ID: <201302090928.43929.arnd@arndb.de>
References: <1357885223-19243-1-git-send-email-vgupta@synopsys.com> <20130208230127.5F3063E2C27@localhost> <5115F076.5000909@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5115F076.5000909@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-serial@vger.kernel.org

On Saturday 09 February 2013, Vineet Gupta wrote:
> On Saturday 09 February 2013 04:31 AM, Grant Likely wrote:
> > On Fri, 11 Jan 2013 11:50:23 +0530, Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >> +- clock-frequency   : the input clock frequency for the UART
> >> +- baud                      : baud rate for UART
> > change 'baud' to 'current-speed'. There is already precedence for this
> > with other serial devices.
> 
> While I'm OK with this - I can only see of_serial.c following the rule :-)
> More importantly I'm not clear about the logistics of this fix. Obviously this has
> a bearing on DT files in arch/arc/boot/*. So are such changes (platform + driver)
> routed thru the subsystem tree or the arch tree or bits from both with
> bisectability not considered - which feels wrong. We have to also consider the
> fact that Greg has closed the tty/serial for 3.9. So while I have no objection to
> your comment, it seems that the it needs to wait till 3.9-rc1 - or is there an
> alternate way.

I'd consider this one a bug fix, so while Greg is not accepting any new
features for the serial tree, I think it should still get in that way
and should not be controversial as an add-on change.

	
	Arnd
