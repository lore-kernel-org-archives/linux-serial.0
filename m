From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Date: Sat, 3 Aug 2002 01:12:10 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020803011210.A19722@flint.arm.linux.org.uk>
References: <20020802154924.A5505@baldur.yggdrasil.com> <20020803005626.D16963@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20020803005626.D16963@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 03, 2002 at 12:56:26AM +0100
List-Id: linux-serial@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: tytso@mit.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, axel@hh59.org

On Sat, Aug 03, 2002 at 12:56:26AM +0100, Russell King wrote:
> 	# Look for usages.
> 	next unless m/LINUX_VERSION_CODE/o;

It should probably look for the other two macros in linux/version.h as
well btw, so it could be generating false negatives.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

