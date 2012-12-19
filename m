From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Wed, 19 Dec 2012 19:45:35 +0530
Message-ID: <50D1CC07.6070506@nvidia.com>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com> <20121217171027.6AE573E0BDD@localhost> <50CF8F36.2030309@wwwdotorg.org> <20121219130151.F29CA3E0AD7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121219130151.F29CA3E0AD7@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 19 December 2012 06:31 PM, Grant Likely wrote:
> On Mon, 17 Dec 2012 14:31:34 -0700, Stephen Warren<swarren@wwwdotorg.org>  wrote:
>> On 12/17/2012 10:10 AM, Grant Likely wrote:
>>> On Mon, 17 Dec 2012 17:40:49 +0530, Laxman Dewangan<ldewangan@nvidia.com>  wrote:
>>
>> Aren't we still supposed to support platform data so that it can
>> override what's in DT in order to fix up bad DTs? Or, has that
>> requirement been dropped. If it has, we can drop a bunch of code from a
>> variety of Tegra-specific drivers, I expect.
> Do you have an actual user for this? If not, then don't borrow trouble.
> Just drop it. Things like platform_data can always be added later only
> if it is needed.

Currently all our board supports DT. we are not using any driver 
instantiated by board files.
I will remove the platform data for current patch and if it is require 
then will add later with reasoning.

Hope this will be fine with Stephen also so that  this basic patch can 
be included into tree soon.


