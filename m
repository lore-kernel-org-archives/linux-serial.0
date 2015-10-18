From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [v7] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Sat, 17 Oct 2015 22:57:45 -0700
Message-ID: <20151018055745.GA31909@kroah.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1444121610-11832-1-git-send-email-noamc@ezchip.com>
 <1444121610-11832-2-git-send-email-noamc@ezchip.com>
 <20151018040614.GA15152@kroah.com>
 <DB5PR02MB11415C0130C759F96183C0E0D63B0@DB5PR02MB1141.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB5PR02MB11415C0130C759F96183C0E0D63B0@DB5PR02MB1141.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 18, 2015 at 05:30:23AM +0000, Noam Camus wrote:
> > From: Greg KH [mailto:gregkh@linuxfoundation.org] 
> > Sent: Sunday, October 18, 2015 7:06 AM
> 
> > This patch still doesn't apply at all to my tty-next branch, what are you making it against?
> 
> > Please fix it up and resend.
> 
> The patch is against v4.3-rc4
> I will update to rc5

Please make it against my tty-testing branch of tty.git on
git.kernel.org, that is the issue here, you are working against a
"clean" tree, not one with all of the other tty/serial changes in it.

thanks,

greg k-h
