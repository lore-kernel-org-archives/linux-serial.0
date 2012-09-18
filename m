From: "Steven J. Ackerman" <steve-I01wfHm1r9xGyKhy+UYuEA@public.gmane.org>
Subject: RE: Linux USB Serial
Date: Tue, 18 Sep 2012 10:00:11 -0400
Message-ID: <002e01cd95a5$ec0a4190$c41ec4b0$@acscontrol.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> <87zk4o1kh4.fsf@nemi.mork.no> <00b801cd9518$715dd160$54197420$@acscontrol.com> <5789366.GGq3fAeCyr@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5789366.GGq3fAeCyr-ugxBuEnWX9yG/4A2pS7c2Q@public.gmane.org>
Content-Language: en-us
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Oliver Neukum' <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: =?iso-8859-1?Q?'Bj=F8rn_Mork'?= <bjorn-yOkvZcmFvRU@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> It shouldn't. Your device follows the CDC ACM specification, aside from
> the incorrect subclass. Such devices don't generate /dev/ttyUSB devices
> nodes. They generate /dev/ttyACM nodes.
> 

Thank you.  I did some more research on this last night and found out that 
I was being mis-lead by observing how other USB Serial devices were 
working and used under Linux - without having to install a driver.
Apparently 
these were all using the FTDI chip - and there is a driver that is already 
installed for them.

> That is the wrong driver. usbserial is for vendor specific serial devices.
> Your device follows a class specification. You need cdc_acm. As soon
> as the subclass is fixed, it should autoload.
> 

Yes - the driver now autoloads and I can communicate with the device 
using the /dev/ttyACM0 node. I was able to install picocom and talk to and 
from our display.

Thanks to everyone who replied to this question for your assistance.

Steven J. Ackerman, Consultant
ACS, Sarasota, FL
http://www.acscontrol.com
mailto:steve-I01wfHm1r9xGyKhy+UYuEA@public.gmane.org





--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
