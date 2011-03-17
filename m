From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] serial: 8250: Add a notifier chain for driver
	registration.
Date: Thu, 17 Mar 2011 11:42:19 -0700
Message-ID: <4D82560B.4090800@caviumnetworks.com>
References: <1300325167-26433-1-git-send-email-ddaney@caviumnetworks.com>
	<1300325167-26433-2-git-send-email-ddaney@caviumnetworks.com>
	<20110317121849.49d7c425@lxorguk.ukuu.org.uk>
	<20110317182510.GN9597@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110317182510.GN9597-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

On 03/17/2011 11:25 AM, Grant Likely wrote:
> On Thu, Mar 17, 2011 at 12:18:49PM +0000, Alan Cox wrote:
>> On Wed, 16 Mar 2011 18:26:06 -0700
>> David Daney<ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>  wrote:
>>
>>> The 8250 driver is a bit weird in that in addition to supporting
>>> platform devices, extra devices can be added by calling
>>> serial8250_register_port().
>>>
>>> The problem is that if we call serial8250_register_port() before the
>>> driver is initialized Bad Things happen (we dereference NULL
>>> pointers).
>>>
>>> There doesn't seem to be a general way to know if a driver has been
>>> initialized
>>
>> I've had a bigger dig into this. I think the correct answer is probably
>> "always go via platform devices or similar". That *is* the notifier in
>> the kernel of today. serial8250_register_port ultimately should I think
>> ultimatly become an internal helper.
>
> +1
>
> Depending on serial8250_register_port() definitely the wrong thing to
> do for platform support code.  It would be better to figure out how to
> get the dt bits you need into 8250.c or of_serial.c.
>

IMHO, of_serial.c is no better than my board/chip specific code that 
calls serial8250_register_port().

Really what would be ideal would be a hook to add a dev.platform_data 
pointer to the appropriate struct plat_serial8250_port when the platform 
device is created.  It is possible that the platform bus notifiers could 
be used for this.  We would also want to have a way to add an 
of_device_id to those recognized by 8250.c

If we did that, serial8250_probe() would automatically do the right thing.

David Daney
