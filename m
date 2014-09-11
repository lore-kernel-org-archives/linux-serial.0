From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
Date: Thu, 11 Sep 2014 11:50:53 -0400
Message-ID: <20140911155053.GF26178@thunk.org>
References: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com>
 <20140911000343.GA5328@kroah.com>
 <5410E8A2.5030802@hurleysoftware.com>
 <20140911002410.GA11732@kroah.com>
 <5410F08D.10707@hurleysoftware.com>
 <20140911135610.GD15632@thunk.org>
 <5411C264.8000105@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5411C264.8000105@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 11, 2014 at 11:40:20AM -0400, Peter Hurley wrote:
> 
> This is the basic interpretation I assumed, and most of what the tty core
> already did.

Yes, I know.  :-)

So it's been a long time since I've had anything to do with the tty
code, but FWIW, I'd agree with merging Peter's patch.

Cheers,

					- Ted
