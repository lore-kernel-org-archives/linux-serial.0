From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 00/05] serial: sh-sci: Hardware flow control update
 V2
Date: Thu, 19 Mar 2015 11:57:19 -0400
Message-ID: <550AF1DF.4070509@hurleysoftware.com>
References: <20150319014933.14235.44835.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150319014933.14235.44835.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

Hi Magnus,

On 03/18/2015 09:49 PM, Magnus Damm wrote:
> serial: sh-sci: Hardware flow control update V2
> 
> [PATCH v2 01/05] serial: sh-sci: Break out default CTS/RTS pin setup
> [PATCH v2 02/05] serial: sh-sci: Fix default RTS handling
> [PATCH v2 03/05] serial: sh-sci: Expose default CTS pin
> [PATCH v2 04/05] serial: sh-sci: Add SCIFA/SCIFB CTS/RTS pin setup
> [PATCH v2 05/05] serial: sh-sci: Expose SCIFA/SCIFB CTS pin
> 
> These patches are my latest take at improving CTS/RTS pin handling in
> the SCIF driver. The goal for these patches is to improve the default
> hardware flow control handling and also add CTS/RTS support for SCIFA/SCIFB.

The serial core expects RTS pin control to be implemented via the driver's
set_mctrl() method, and will take care of raising and lowering it when
necessary.

Regards,
Peter Hurley

