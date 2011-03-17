From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [RFC PATCH 0/2] serial: Hack up 8520.c for evil device tree hookin.
Date: Wed, 16 Mar 2011 18:26:05 -0700
Message-ID: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

I wanted to get some feedback on my attempts to control my serial
device registration with device tree data.

It was suggested by Grant Likely that I could use of_serial.c for my
purposes.  However I think it is simpler to do my own registration
code, because I need to set my own device type, required port flags,
and I/O functions, instead of using general purpose ones.  Adding this
to of_serial.c would be quite ugly, so I would like to keep it with my
chip/board code.

This leads to a problem: You cannot call serial8250_register_port()
until the 8250.c driver is registered.  of_serial.c is lucky that it
comes after 8250.c in the make file so that the device initcall order
is correct.  When I put the code in my board's serial.c file, I am not
so lucky.  To get the initialization order correct, I add a notifier
chain to 8250.c

What say you all to this approach?

David Daney (2):
  serial: 8250: Add a notifier chain for driver registration.
  MIPS: Octeon: Use device tree to register serial ports.

 arch/mips/cavium-octeon/serial.c |  140 ++++++++++++++++----------------------
 drivers/tty/serial/8250.c        |   20 ++++++
 include/linux/serial_8250.h      |   21 ++++++
 3 files changed, 101 insertions(+), 80 deletions(-)

-- 
1.7.2.3
