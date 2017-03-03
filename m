From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 18:07:39 +0100
Message-ID: <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 03/03/2017 17:59, Andreas F=E4rber wrote:

> Hi,
> =

> Am 03.03.2017 um 17:42 schrieb Marc Gonzalez:
>> I'm confused about early consoles and earlyprintk, and all that good stu=
ff.
>> When my kernel panics, I don't get the expected output.
>>
>> Using "mem=3D256M ignore_loglevel earlyprintk"
> [...]
>> [    0.014325] Console: colour dummy device 80x30
>> [    0.018885] console [tty0] enabled
>> [    0.022396] bootconsole [earlycon0] disabled
>>
>> And it hangs there.
>>
>>
>> If I use an explicit console=3D configuration, I do see the panic.
>> Using "mem=3D256M ignore_loglevel console=3DttyS0,115200 earlyprintk"
> [...]
>> [    0.014325] Console: colour dummy device 80x30
>> [    0.018899] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 54.25 BogoMIPS (lpj=3D90000)
> [...]
> =

> I have reported a similar phenomenon for multiple new SoCs.
> =

>> I suppose this is related to my DT description?
>>
>> 	chosen {
>> 		stdout-path =3D "serial:115200n8";
>> 	};
>>
>> Isn't stdout-path =3D "serial:115200n8" supposed to be equivalent to
>> console=3DttyS0,115200 ?
> =

> First of all, that should probably be serial0, and it needs to be
> defined as an alias. In my case that's a given.

My DT root node contains

	aliases {
		serial =3D &uart;
		eth0 =3D &eth0;
	};

Should I be using serial0 everywhere?
(I thought I could call it "foo", if I wanted.)

> And yes, AFAIU stdout-path =3D "serialX:115200n8" should lead to
> ttyFOOX,115200n8 being used, in your case it may be ttyS0.

Regards.
