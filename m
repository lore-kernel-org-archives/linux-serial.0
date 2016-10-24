From: Sean Young <sean@mess.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Mon, 24 Oct 2016 14:52:35 +0100
Message-ID: <20161024135235.GA29984@gofer.mess.org>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 21, 2016 at 10:55:40AM -0500, Nathan Zimmer wrote:
> It didn't seem to make a difference as far as output.
> Did I miss a config option? or something else?
> 
> [    0.000000] Linux version 3.6.0 (root@r1i2n0) (gcc version 4.3.4
> [gcc-4_3-branch revision 152973] (SUSE Linux) ) #3 SMP Mon Oct 17 20:43:34
> EDT 2016
> [    0.000000] Command line:
> root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2
> resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
> crashkernel=256M-:128M loglevel=8 pnp.debug=1
> ...
> [    2.076084] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> [    2.097001] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    2.097844] serial 00:04: unable to assign resources
> [    2.098303] serial: probe of 00:04 failed with error -16

Ehm is this kernel compiled with CONFIG_PNP_DEBUG_MESSAGES? Are you 
getting any debug messages? You could try ignore_loglevel. 


Sean
