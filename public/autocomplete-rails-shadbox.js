! function (t) {
	t.fn.railsAutocomplete = function (e) {
		var a = function () {
			this.railsAutoCompleter || (this.railsAutoCompleter = new t.railsAutocomplete(this))
		};
		if (void 0 !== t.fn.on) {
			if (!e) return;
			return t(document).on("focus", e, a)
		}
		return this.live("focus", a)
	}, t.railsAutocomplete = function (t) {
		var e = t;
		this.init(e)
	}, t.railsAutocomplete.options = {
		showNoMatches: !0,
		noMatchesLabel: "no existing match"
	}, t.railsAutocomplete.fn = t.railsAutocomplete.prototype = {
		railsAutocomplete: "0.0.1"
	}, t.railsAutocomplete.fn.extend = t.railsAutocomplete.extend = t.extend, t.railsAutocomplete.fn.extend({
		init: function (e) {
			function a(t) {
				return t.split(e.delimiter)
			}

			function i(t) {
				return a(t).pop().replace(/^\s+/, "")
			}
			e.delimiter = t(e).attr("data-delimiter") || null, e.min_length = t(e).attr("data-min-length") || t(e).attr("min-length") || 2, e.append_to = t(e).attr("data-append-to") || null, e.autoFocus = t(e).attr("data-auto-focus") || !1, t(e).autocomplete({
				appendTo: e.append_to,
				autoFocus: e.autoFocus,
				delay: t(e).attr("delay") || 0,
				source: function (a, r) {
					var n = this.element[0],
						o = {
							term: i(a.term)
						};
					t(e).attr("data-autocomplete-fields") && t.each(t.parseJSON(t(e).attr("data-autocomplete-fields")), function (e, a) {
						o[e] = t(a).val()
					}), t.getJSON(t(e).attr("data-autocomplete"), o, function () {
						var a = {};
						t.extend(a, t.railsAutocomplete.options), t.each(a, function (i, r) {
							if (a.hasOwnProperty(i)) {
								var n = t(e).attr("data-" + i);
								a[i] = n ? n : r
							}
						}), 0 == arguments[0].length && t.inArray(a.showNoMatches, [!0, "true"]) >= 0 && (arguments[0] = [], arguments[0][0] = {
							id: "",
							label: a.noMatchesLabel
						}), t(arguments[0]).each(function (a, i) {
							var r = {};
							r[i.id] = i, t(e).data(r)
						}), r.apply(null, arguments), t(n).trigger("railsAutocomplete.source", arguments)
					})
				},
				change: function (e, a) {
					if (t(this).is("[data-id-element]") && "" !== t(t(this).attr("data-id-element")).val() && (t(t(this).attr("data-id-element")).val(a.item ? a.item.id : "").trigger("change"), t(this).attr("data-update-elements"))) {
						var i = t.parseJSON(t(this).attr("data-update-elements")),
							r = a.item ? t(this).data(a.item.id.toString()) : {};
						if (i && "" === t(i.id).val()) return;
						for (var n in i) {
							var o = t(i[n]);
							o.is(":checkbox") ? null != r[n] && o.prop("checked", r[n]) : o.val(a.item ? r[n] : "").trigger("change")
						}
					}
				},
				search: function () {
					var t = i(this.value);
					return t.length < e.min_length ? !1 : void 0
				},
				focus: function () {
					return !1
				},
				select: function (i, r) {
					if (r.item.value = r.item.value.toString(), -1 != r.item.value.toLowerCase().indexOf("no match") || -1 != r.item.value.toLowerCase().indexOf("too many results")) return t(this).trigger("railsAutocomplete.noMatch", r), !1;
					var n = a(this.value);
					if (n.pop(), n.push(r.item.value), null != e.delimiter) n.push(""), this.value = n.join(e.delimiter);
					else if (this.value = n.join(""), t(this).attr("data-id-element") && t(t(this).attr("data-id-element")).val(r.item.id).trigger("change"), t(this).attr("data-update-elements")) {
						var o = r.item,
							l = -1 != r.item.value.indexOf("Create New") ? !0 : !1,
							u = t.parseJSON(t(this).attr("data-update-elements"));
						for (var s in u) "checkbox" === t(u[s]).attr("type") ? o[s] === !0 || 1 === o[s] ? t(u[s]).attr("checked", "checked") : t(u[s]).removeAttr("checked") : l && o[s] && -1 == o[s].indexOf("Create New") || !l ? t(u[s]).val(o[s]).trigger("change") : t(u[s]).val("").trigger("change")
					}
					var c = this.value;
					return t(this).bind("keyup.clearId", function () {
						t.trim(t(this).val()) != t.trim(c) && (t(t(this).attr("data-id-element")).val("").trigger("change"), t(this).unbind("keyup.clearId"))
					}), t(e).trigger("railsAutocomplete.select", r), !1
				}
			}), t(e).trigger("railsAutocomplete.init")
		}
	}), t(document).ready(function () {
		t("input[data-autocomplete]").railsAutocomplete("input[data-autocomplete]")
	})
}(jQuery);