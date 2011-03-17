From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] serial: 8250: Add a notifier chain for driver
	registration.
Date: Thu, 17 Mar 2011 13:13:06 -0700
Message-ID: <4D826B52.3060304@caviumnetworks.com>
References: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
	<1300325167-26433-2-git-send-email-ddaney@caviumnetworks.com>
	<20110317121849.49d7c425@lxorguk.ukuu.org.uk>
	<20110317182510.GN9597@angua.secretlab.ca>
	<4D82560B.4090800@caviumnetworks.com>
	<20110317184723.GQ9597@angua.secretlab.ca>
	<20110317192441.69c699b1@lxorguk.ukuu.org.uk>
	<20110317193149.GD12824@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110317193149.GD12824-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 03/17/2011 12:31 PM, Grant Likely wrote:
> On Thu, Mar 17, 2011 at 07:24:41PM +0000, Alan Cox wrote:
>>>> If we did that, serial8250_probe() would automatically do the right thing.
>>>
>>> Take a look at the way arch/powerpc/platforms/512x/pdm360ng.c uses a
>>> notifier for amending a platform_device with additional data..
>>
>> I tend to view arch specific embedded code as rather like very dubious
>> parties. What goes on in other peoples' house out of sight is none of my
>> business.
>>
>> The 8250 however is core code so it should keep its clothers on and behave
>> in a manner befitting its status.
>>
>> What part of the problem can't be solved by doing it properly using the
>> device registration interfaces we have today ?
>
> Device registration isn't the problem.  The problem is supplying
> machine-specific callbacks from the board support code to the
> drivers.  When devices are sourced from a device tree, it is easy to
> get data about the device out of the tree, but it is really hard to
> get callback pointers.  To make it all work without this fiddling
> about, the octeon serial_{in,out} implementation would need to be
> rolled into of_serial.c (which FWIW, I have absolutely no problem
> with).
>

The only problem I have with that is that it ends up moving chip 
specific erratum workarounds into drivers/tty/serial instead of 
arch/mips/cavium-octeon.

I will think about this more.

David Daney
