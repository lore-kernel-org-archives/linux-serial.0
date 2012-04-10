From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/3] tegra, serial8250: add ->handle_break() uart_port
 op
Date: Tue, 10 Apr 2012 12:17:00 -0600
Message-ID: <4F84791C.7090307@wwwdotorg.org>
References: <20120409194514.8004.53204.stgit@dwillia2-linux.jf.intel.com>	<20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>	<4F84575F.7090909@wwwdotorg.org> <CABE8wwsDM=4Lp5Fa79V29tG2RypfA-MxN7zfhtze7sOLCVdL7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABE8wwsDM=4Lp5Fa79V29tG2RypfA-MxN7zfhtze7sOLCVdL7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org, Sudhakar Mamillapalli <sudhakar@fb.com>, linux-kernel@vger.kernel.org, ArndBergmannarnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 04/10/2012 11:36 AM, Dan Williams wrote:
> On Tue, Apr 10, 2012 at 8:53 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/09/2012 01:48 PM, Dan Williams wrote:
>>> The "KT" serial port has another use case for a "received break" quirk,
>>> so before adding another special case to the 8250 core take this
>>> opportunity to push such quirks out of the core and into a uart_port op.
...
>>> diff --git a/include/linux/of_serial.h b/include/linux/of_serial.h
>> ...
>>> + * FIXME remove this file when tegra finishes conversion to open firmware,
>>
>> remove this *prototype* not *file*?
> 
> The entire file should go away since it is only there to export
> tegra_serial_handle_break to the deprecated board files.  Once this is
> open firmware only tegra_serial_handle_break can be marked static,
> right?

Ah yes, right.
