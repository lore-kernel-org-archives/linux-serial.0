From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Wed, 7 Aug 2019 17:05:43 +0000
Message-ID: <VI1PR0402MB2863C28FAB5DA6356280432BDFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
 <20190806184042.GA26041@kroah.com>
 <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190807165646.GA6584@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Larisa Ileana Grigore <larisa.grigore@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 8/7/2019 7:56 PM, gregkh@linuxfoundation.org wrote:
> On Wed, Aug 07, 2019 at 04:42:17PM +0000, Stefan-gabriel Mirea wrote:
>> On 8/6/2019 9:40 PM, gregkh@linuxfoundation.org wrote:
>>> On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:

<snip>

>>>> Other than that, I do not see anything wrong with the addition of a
>>>> define in serial_core.h for this purpose (which is also what most of the
>>>> serial drivers do, including amba-pl011.c, mentioned in
>>>> Documentation/driver-api/serial/driver.rst as providing the reference
>>>> implementation), so please be more specific.
>>>
>>> I am getting tired of dealing with merge issues with that list, and no
>>> one seems to be able to find where they are really needed for userspace,
>>> especially for new devices.  What happens if you do not have use it?
>>
>> I see. If I drop its usage completely and leave 'type' from the
>> uart_port as 0, uart_port_startup() will fail when finding that
>> uport->type == PORT_UNKNOWN at [1] (there may be other effects as well,
>> e.g. due to the check in uart_configure_port[2]).
>>
>> So I suppose that I need to define some nonzero 'PORT_KNOWN' macro in
>> the driver and use that one internally for 'type'. Is my understanding
>> correct? Will there be any problems if I define it to a positive integer
>> which is already assigned to another driver, according to serial_core.h?
> 
> Ugh, ok, that's messy, nevermind.  Keep the #define in there, I will try
> to figure out how to move all of these at once sometime in the future...
> 
> sorry for the noise.

No problem, thank you for your time.

Regards,
Stefan
