From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 18:17:47 +0100
Message-ID: <3fc43a98-71b1-03df-6809-726230dc27d1@suse.de>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
 <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Am 03.03.2017 um 18:07 schrieb Marc Gonzalez:
> On 03/03/2017 17:59, Andreas F=E4rber wrote:
>> Am 03.03.2017 um 17:42 schrieb Marc Gonzalez:
>>> 	chosen {
>>> 		stdout-path =3D "serial:115200n8";
>>> 	};
>>>
>>> Isn't stdout-path =3D "serial:115200n8" supposed to be equivalent to
>>> console=3DttyS0,115200 ?
>>
>> First of all, that should probably be serial0, and it needs to be
>> defined as an alias. In my case that's a given.
> =

> My DT root node contains
> =

> 	aliases {
> 		serial =3D &uart;
> 		eth0 =3D &eth0;
> 	};
> =

> Should I be using serial0 everywhere?
> (I thought I could call it "foo", if I wanted.)

Most serial drivers call of_alias_get_id() to retrieve the index - feel
free to add some debug output to see whether "serial" and "serial0"
behave the same, I haven't tested - literal "foo" will definitely behave
differently since the drivers check for "serial".

Regards,
Andreas

-- =

SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
