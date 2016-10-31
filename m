From: Sean Young <sean@mess.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Mon, 31 Oct 2016 20:27:06 +0000
Message-ID: <20161031202706.GA10263@gofer.mess.org>
References: <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
 <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan <nzimmer@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 30, 2016 at 10:33:02AM -0500, Nathan wrote:
> I think this should be PNP0501 instead of PNP0c02.
> Once I alter that then when I boot the serial comes up on irq 3. However it
> still hangs.
> I'll keep digging.

Well that's that theory out of the window. I'm not sure where to look now,
I would start by enabling as many as possible of the "kernel hacking" config
options and see if anything gets caught.

Looking at your earlier messages, you have a collection of percpu allocation
failures. That might be worth resolving before anything else.


Sean
