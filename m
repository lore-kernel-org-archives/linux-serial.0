From: Greg KH <greg@kroah.com>
Subject: Re: [v2 3/3] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Mon, 3 Aug 2015 16:44:06 -0700
Message-ID: <20150803234406.GC5257@kroah.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
 <1437886478-29273-3-git-send-email-noamc@ezchip.com>
 <1437886478-29273-4-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437886478-29273-4-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 26, 2015 at 07:54:38AM +0300, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> Add support for OF option "no-loopback-test"
> 
> use case: simulator which does not implements loopback test mode.

Can't you just fix the simulator to be "correct"?
