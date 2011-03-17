From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] serial: 8250: Add a notifier chain for driver
	registration.
Date: Thu, 17 Mar 2011 23:48:14 +0000
Message-ID: <20110317234814.421f1aa4@lxorguk.ukuu.org.uk>
References: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
	<1300325167-26433-2-git-send-email-ddaney@caviumnetworks.com>
	<20110317121849.49d7c425@lxorguk.ukuu.org.uk>
	<20110317182510.GN9597@angua.secretlab.ca>
	<4D82560B.4090800@caviumnetworks.com>
	<20110317184723.GQ9597@angua.secretlab.ca>
	<20110317192441.69c699b1@lxorguk.ukuu.org.uk>
	<20110317193149.GD12824@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110317193149.GD12824-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> Device registration isn't the problem.  The problem is supplying
> machine-specific callbacks from the board support code to the
> drivers.  When devices are sourced from a device tree, it is easy to
> get data about the device out of the tree, but it is really hard to
> get callback pointers.  To make it all work without this fiddling
> about, the octeon serial_{in,out} implementation would need to be
> rolled into of_serial.c (which FWIW, I have absolutely no problem
> with).

Disagree - the arch code needs to register I/O method descriptions with
the of_serial code they don't neccessarily need to be in it.

Ie you'd have something like

	of_serial8250_register_ops("dt-op-type-name-blah", &ops);

in the early boot code, and the ops can be in the arch, providing the ops
has a module owner field the rest can even work modular. Sure the stuff
should be able to describe standard forms directly without extra methods
being registered but for the special stuff I think that is the right
approach

Funnily enough I'm in the middle of trying to rip the rm9k, au and other
crap out of 8250.c by doing this for the UPIO_xxx ids and once you have
an ops struct you can also then go and boot out the resource claim crap
and package it all nicely.
