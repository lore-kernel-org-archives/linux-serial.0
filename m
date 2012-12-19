From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Wed, 19 Dec 2012 09:58:18 -0700
Message-ID: <50D1F22A.6090801@wwwdotorg.org>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
 <20121217171027.6AE573E0BDD@localhost> <50CF8F36.2030309@wwwdotorg.org>
 <20121219130151.F29CA3E0AD7@localhost> <50D1CC07.6070506@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50D1CC07.6070506-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jslaby-AlSwsSmVLrQ@public.gmane.org" <jslaby-AlSwsSmVLrQ@public.gmane.org>, "alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 12/19/2012 07:15 AM, Laxman Dewangan wrote:
> On Wednesday 19 December 2012 06:31 PM, Grant Likely wrote:
>> On Mon, 17 Dec 2012 14:31:34 -0700, Stephen
>> Warren<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>  wrote:
>>> On 12/17/2012 10:10 AM, Grant Likely wrote:
>>>> On Mon, 17 Dec 2012 17:40:49 +0530, Laxman
>>>> Dewangan<ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>  wrote:
>>>
>>> Aren't we still supposed to support platform data so that it can
>>> override what's in DT in order to fix up bad DTs? Or, has that
>>> requirement been dropped. If it has, we can drop a bunch of code from a
>>> variety of Tegra-specific drivers, I expect.
>> Do you have an actual user for this? If not, then don't borrow trouble.
>> Just drop it. Things like platform_data can always be added later only
>> if it is needed.
> 
> Currently all our board supports DT. we are not using any driver
> instantiated by board files.
> I will remove the platform data for current patch and if it is require
> then will add later with reasoning.
> 
> Hope this will be fine with Stephen also so that  this basic patch can
> be included into tree soon.

I'm fine with it; it's just a change in policy that hadn't been
communicated before.
