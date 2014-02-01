From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: PROBLEM: BUG: scheduling while atomic in the 8250 serial driver
Date: Sat, 01 Feb 2014 12:27:39 -0500
Message-ID: <52ED2E8B.2050908@hurleysoftware.com>
References: <52ECED0D.4090202@ewanet.ch> <52ED07F1.60304@hurleysoftware.com> <20140201150436.GA8992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:33236 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933102AbaBAR1r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Feb 2014 12:27:47 -0500
In-Reply-To: <20140201150436.GA8992@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Beat Bolli <bbolli@ewanet.ch>, linux-serial@vger.kernel.org

On 02/01/2014 10:04 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 01, 2014 at 09:42:57AM -0500, Peter Hurley wrote:
>> You can't use low_latency; only devices that receive data in
>> non-interrupt contexts (such as USB serial devices) can.
>
> USB serial devices get their data in interrupt context, until we fix USB
> callbacks to be threaded, which might happen one day...

Oh yeah, you're right.

Weird. Back when I was writing the Firewire serial driver,
I experimented with low_latency some but decided it wasn't worth
the hassle. I could swear I was copying from some USB serial
driver...

Regards,
Peter Hurley

