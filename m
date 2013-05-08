From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: =?UTF-8?B?UmVbMl06IFtSRkMgMy84XSBtZmQ6c3lzY29uOiBJbnRyb2R1Y2UgY2xhaW0v?=
 =?UTF-8?B?cmVhZC93cml0ZS9yZWxlYXNlIEFQSXM=?=
Date: Wed, 08 May 2013 23:41:17 +0400
Message-ID: <1368042077.83893040@f59.mail.ru>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work-JGs/UdohzUI@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201305081650.23264.arnd-r2nGTMty4D4@public.gmane.org>
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
To: =?UTF-8?B?QXJuZCBCZXJnbWFubg==?= <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?VmlyZXNoIEt1bWFy?= <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?V2lsbCBEZWFjb24=?= <will.deacon-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?SmlyaSBTbGFieQ==?= <jslaby-AlSwsSmVLrQ@public.gmane.org>, =?UTF-8?B?UnVzc2VsbCBLaW5n?= <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, =?UTF-8?B?Tmljb2xhcyBQaXRyZQ==?= <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?U3Jpbml2YXMgS0FOREFHQVRMQQ==?= <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?SmFzb24gQ29vcGVy?= <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, =?UTF-8?B?Um9iIEhlcnJpbmc=?= <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?B?U3R1YXJ0IE1lbmVmeQ==?= <stuart.menefy-qxv4g6HH51o@public.gmane.org>, =?UTF-8?B?U3RlcGhlbiBXYXJyZW4=?= <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?= <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kerne
List-Id: linux-serial@vger.kernel.org

> On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
> > 
> > This patch introduces syscon_claim, syscon_read, syscon_write,
> > syscon_release APIs to help drivers to use syscon registers in much more
> > flexible way.
> > 
> > With this patch, a driver can claim few/all bits in the syscon registers
> > and do read/write and then release them when its totally finished with
> > them, in the mean time if another driver requests same bits or registers
> > the API will detect conflit and return error to the second request.
> > 
> > Reason to introduce this API.
> > System configuration/control registers are very basic configuration
> > registers arranged in groups across ST Settop Box parts. These registers
> > are independent of IP itself. Many IPs, clock, pad and other functions
> > are wired up to these registers.
> > 
> > In many cases a single syconf register contains bits related to multiple
> > devices, and therefore it need to be shared across multiple drivers at
> > bit level. The same IP block can have different syscon mappings on
> > different SOCs.
> > 
> > Typically in a SOC there will be more than hundreds of these registers,
> > which are again divided into groups.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
> > CC: Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>
> 
> My feeling is that syscon is the wrong place for this functionality,
> since regmap already handles (some of?) these issues. If you need
> additional synchronization, it's probably best to extend regmap
> as needed so other code besides syscon can take advantage of that
> as well.
+1

---
