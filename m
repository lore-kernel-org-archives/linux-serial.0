From: Paul Mackerras <paulus@au1.ibm.com>
Subject: Re: RS485 communication
Date: Tue, 25 Mar 2003 14:23:12 +1100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <15999.52128.840507.233503@argo.ozlabs.ibm.com>
References: <20030324114308.30965.qmail@indiainfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030324114308.30965.qmail@indiainfo.com>
List-Id: linux-serial@vger.kernel.org
To: Cigol C <linuxppp@indiainfo.com>
Cc: linux-serial@vger.kernel.org, linux-ppp@vger.kernel.org, redhat-ppp-list@redhat.com, linux-kernel@vger.kernel.org

Cigol C writes:

> i) Linux PPP interface with IP: Registration, Packet send/receive/close
> ii) Linux PPP interface with serial driver:Registration, Packet send/receive/close

See Documentation/networking/ppp_generic.txt in any recent linux
kernel source tree.

> iii) Linux PPP server configuration and initial sequence of working. i.e. associating a IP address with serial device and ppp0

You will need a plugin for pppd that provides a new channel type.  See
the rp-pppoe plugin for an example of how this is done.

However, given that rs485 is multidrop, I really don't think PPP is
the best protocol to use.
