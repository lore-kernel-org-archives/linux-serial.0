From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: Non-standard baud rate setting 14400 ..Possible?
Date: Fri, 20 Feb 2004 16:17:56 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040220161756.N11138@microdata-pos.de>
References: <007101c38f3e$e6419d70$cf14a8c0@sampath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:46096
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S261283AbUBTPR5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Feb 2004 10:17:57 -0500
Content-Disposition: inline
In-Reply-To: <007101c38f3e$e6419d70$cf14a8c0@sampath>; from sampath@spartanlabs.com on Fri, Oct 10, 2003 at 08:27:59PM +0530
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello a little bit late answer ;-)

On Fri, Oct 10, 2003 at 08:27:59PM +0530, Sampath Kumar wrote:
> Hello ,
> 
> Is there a way to set the serial port on the i386 Linux 2.4.17 at non
> standard baud rates like 14400,28800,etc.?

I it is a way.

cflags -> B38400;  /* set the baud to 38400 */  

static int pos_set_28800(int fd) {
     struct serial_struct serinfo;
     int ret;
     if ((ret = ioctl(fd, TIOCGSERIAL, &serinfo)) < 0) {
    	   fprintf(stderr,"Cannot get serial info\n"); 
     } else {
    	   serinfo.custom_divisor = 4;
			/*  Baudbase 115200/4 = 28800 
				     115200/8 = 14400 */

	   serinfo.flags &=  ~ASYNC_SPD_MASK;
	   serinfo.flags |=  ASYNC_SPD_CUST;		
	   if ((ret = ioctl(fd, TIOCSSERIAL, &serinfo)) < 0) {
	        fprintf(stderr, "Cannot set serial info\n");
	   }
     }
     return 0;
}

or set it with setserial.

It's running with kernel 2.4.xx

Michael Westermann
