From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Sun, 15 Aug 2010 12:59:52 +0300
Message-ID: <4C67BA98.8090405@gmail.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
	<AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
	<4C5BAFF6.10606@gmail.com> <4C5BB462.6010409@samsung.com>
	<008701cb3538$54a12a00$fde37e00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <008701cb3538$54a12a00$fde37e00$%kim@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene.kim@samsung.com>, ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, 'Kyungmin Park' <kmpark@infradead.org>, 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Paulius Zaleckas' <paulius.zaleckas@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 08/06/2010 10:23 AM, Kukjin Kim wrote:
> Joonyoung Shim wrote:
>>
>> On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
>>> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
>>>> Hi,
>>>>
>>>> It's already posted by Mr. Shim
>>>> http://marc.info/?l=linux-arm-kernel&m=127410047306149&w=2
>>>
>>> Darius patch is a little bit cleaner.
>>>
>>
>> OK, it's better.
>>
>> Acked-by: Joonyoung Shim<jy0922.shim@samsung.com>
>>
>
> Hi all,
>
> I think, this should be handled by Ben Dooks....
> As Kyungmin Park said, there was his comment about this.
>

Ben, what's your opinion about that? Are you going to merge that?

> This is just for your information....
>
> ===
>
> On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
>> On 5/18/2010 11:48 AM, Ben Dooks wrote:
>>> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
>>>> Thd dev_name and driver_name should be switched each other.
>>>
>>> Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
>>>
>>> Please provide some information about what problem that this is fixing
>>> and the impact on any existing systems.
>>>
>>
>> The serial device nodes are created to s3c2410_serial* on android
>> platform instead of ttySAC*.
>
> This has been how they've been for ages, surely the android device node
> creation sytstem supports symlinking /dev/SACx ->  /dev/s3c2410_serialx,
> like many other operating sysyerms that can already do this.
>
> Changing this just because android (something as-yet unmerged into mainline)
> does not like it. I'm not even happy with an #ifdef around this.
>
> If you really feel this is a problem that you absolutely must fix in kernel
> then please provide a kernel commandline option to change the serial driver
> name and use that on any platform that needs it. Another way would be to
> update the serial platform data to have a field for which name to choose.
>
